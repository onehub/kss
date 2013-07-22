module Kss
  # Public: Takes a file path of a text file and extracts comments from it.
  # Currently accepts two formats:
  #
  # // Single line style.
  # /* Multi-line style. */
  class CommentParser

    # Public: Is this a single-line comment? // This style
    #
    # line - A String of one line of text.
    #
    # Returns a boolean.
    def self.single_line_comment?(line)
      !!(line =~ /^\s*\/\//)
    end

    # Public: Is this the start of a multi-line comment? /* This style */
    #
    # line - A String of one line of text.
    #
    # Returns a boolean.
    def self.start_multi_line_comment?(line)
      !!(line =~ /^\s*\/\*/)
    end

    # Public: Is this the end of a multi-line comment? /* This style */
    #
    # line - A String of one line of text.
    #
    # Returns a boolean.
    def self.end_multi_line_comment?(line)
      return false if self.single_line_comment?(line)
      !!(line =~ /.*\*\//)
    end

    # Public: Removes comment identifiers for single-line comments.
    #
    # line - A String of one line of text.
    #
    # Returns a String.
    def self.parse_single_line(line)
      cleaned = line.to_s.sub(/\s*\/\//, '')
      cleaned.rstrip
    end

    # Public: Remove comment identifiers for multi-line comments.
    #
    # line - A String of one line of text.
    #
    # Returns a String.
    def self.parse_multi_line(line)
      cleaned = line.to_s.sub(/\s*\/\*/, '')
      cleaned = cleaned.sub(/\*\//, '')
      cleaned.rstrip
    end

    # Public: Initializes a new comment parser object. Does not parse on
    # initialization.
    #
    # file_path_or_string_input - The location of the file to parse as a String, or the String itself.
    # options                   - Optional options hash.
    #   :preserve_whitespace - Preserve the whitespace before/after comment
    #                          markers (default:false).
    #
    def initialize(file_path_or_string_input, options={})
      @options = options
      @options[:preserve_whitespace] = false if @options[:preserve_whitespace].nil?
      if File.exists?(file_path_or_string_input)
        @file_path = file_path_or_string_input
      else
        @string_input = file_path_or_string_input
      end
      @blocks = []
      @parsed = false
    end

    # Public: The different sections of parsed comment text. A section is
    # either a multi-line comment block's content, or consecutive lines of
    # single-line comments.
    #
    # Returns an Array of parsed comment Strings.
    def blocks
      @parsed ? @blocks : parse_blocks
    end

    # Parse the file or string for comment blocks and populate them into @blocks.
    #
    # Returns an Array of parsed comment Strings.
    def parse_blocks
      if !@file_path.nil?
        # the input is an existing file
        File.open @file_path do |file|
          parse_blocks_input(file)
        end
      else
        # @file_path is nil, we then expect the input to be a String
        parse_blocks_input(@string_input)
      end
    end

    def parse_blocks_input(input)
      current_block = nil
      inside_single_line_block = false
      inside_multi_line_block  = false

      input.each_line do |line|
        # Parse single-line style
        if self.class.single_line_comment?(line)
          parsed = self.class.parse_single_line line
          if inside_single_line_block
            current_block += "\n#{parsed}"
          else
            current_block = parsed.to_s
            inside_single_line_block = true
          end
        end

        # Parse multi-lines tyle
        if self.class.start_multi_line_comment?(line) || inside_multi_line_block
          parsed = self.class.parse_multi_line line
          if inside_multi_line_block
            current_block += "\n#{parsed}"
          else
            current_block = parsed
            inside_multi_line_block = true
          end
        end

        # End a multi-line block if detected
        inside_multi_line_block = false if self.class.end_multi_line_comment?(line)

        # Store the current block if we're done
        unless self.class.single_line_comment?(line) || inside_multi_line_block
          @blocks << normalize(current_block) unless current_block.nil?

          inside_single_line_block = false
          current_block = nil
        end
      end
      @parsed = true
      @blocks
    end

    # Normalizes the comment block to ignore any consistent preceding
    # whitespace. Consistent means the same amount of whitespace on every line
    # of the comment block. Also strips any whitespace at the start and end of
    # the whole block.
    #
    # Returns a String of normalized text.
    def normalize(text_block)
      return text_block if @options[:preserve_whitespace]

      # Strip out any preceding [whitespace]* that occur on every line. Not
      # the smartest, but I wonder if I care.
      text_block = text_block.gsub(/^(\s*\*+)/, '')

      # Strip consistent indenting by measuring first line's whitespace
      indent_size = nil
      unindented = text_block.split("\n").collect do |line|
        preceding_whitespace = line.scan(/^\s*/)[0].to_s.size
        indent_size = preceding_whitespace if indent_size.nil?
        if line == ""
          ""
        elsif indent_size <= preceding_whitespace && indent_size > 0
          line.slice(indent_size, line.length - 1)
        else
          line
        end
      end.join("\n")

      unindented.strip
    end

  end
end
