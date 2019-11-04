class AwMouseCommand

	DATA_START = "\x0d\x5a\x03\x00" 
  DATA_END = "\xa5"
  CONTROL_COMMAND = "\x0a\x5a\x03\x04\x03\x00\x02\x00\x00\x01\xa5"

  @type = nil
  @data = nil
  @commands = []

  def initialize(color_type=1, colors=[])
    @type = color_type
    @data = colors
    @commands = []

    return self
  end

  def prepare_commands

    data_colors = [@data.flatten.map{ |c| sprintf("%02X", c) }.join].pack("H*")
    #puts "data colors:"
    #puts data_colors
    color_command = (DATA_START.force_encoding(Encoding::BINARY) + data_colors.force_encoding(Encoding::BINARY) + DATA_END.force_encoding(Encoding::BINARY))
    #puts "color_command:"
    #puts color_command.to_s
     
    @commands.push(color_command)

    if @type != 1 
      control_command = CONTROL_COMMAND

      #puts "color_command:"
      #puts color_command.to_s
      #
      @commands.push(control_command)
    end

    return @commands
  end

end
