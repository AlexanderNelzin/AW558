class AwMouseCommand

  CONTROL = {
    :const_color => {
      :data_start    => "0D5A0300",
      :data_end      => "A5",
      :color_size    => 3
    },
    :morph_color => {
      :data_start    => "0A5A0302",
      :data_end      => "A5",
      :control_start => "0A5A0304030002",
      :control_end   => "0001A5",
      :color_size    => 2
    },
    :pulse_color => {
      :data_start    => "075A0301",
      :data_end      => "A5",
      :control_start => "0A5A0304010001",
      :control_end   => "0001A5",
      :color_size    => 1

    },
    :breath_color => {
      :data_start    => "075A0301",
      :data_end      => "A5",
      :control_start => "0A5A0304020001",
      :control_end   => "0001A5",
      :color_size    => 1
    },
    :firework_color => {
      :data_start    => "075A0301",
      :data_end      => "A5",
      :control_start => "0A5A0304060001",
      :control_end   => "0001A5",
      :color_size    => 1
    },
    # Spectrum works, but does not allow to set colors
    :spectrum_color => {
      :data_start    => "195A0303",
      :data_end      => "A5",
      :control_start => "0A5A0304040003",
      :control_end   => "0001A5",
      :color_size    => 7
    },
    # Rotary works, but does not allow to set colors
    :rotary_color => {
      :data_start    => "195A0303",
      :data_end      => "A5",
      :control_start => "0A5A0304080003",
      :control_end   => "0001A5",
      :color_size    => 7
    },
  }

  @type = nil
  @data = nil
  @speed = nil
  @commands = []

  def initialize(color_type=:const_color, colors=[], change_speed=0)
    @type = color_type
    @data = colors
    @speed = change_speed
    @commands = []

    return self
  end

  def prepare_commands

    data_colors = @data.flatten
    # puts "data colors:"
    # puts (CONST_COLOR_START + data_colors.map{ |c| c.to_s(16) }.join + DATA_END).upcase
    color_command = [(CONTROL[@type][:data_start] + data_colors.map{ |c| "%02X" % c }.join + CONTROL[@type][:data_end]).upcase].pack("H*")
    # puts [(CONST_COLOR_START + data_colors.map{ |c| c.to_s(16) }.join + DATA_END).upcase].pack("H*")
    # puts "color_command:"
    # puts color_command.inspect
    # puts color_command.to_s
     
    @commands.push(color_command)
    # @commands.push(data)

    if CONTROL[@type][:control_start] && CONTROL[@type][:control_end] 
      control_command = [(CONTROL[@type][:control_start] + ("%02X" % @speed.to_s) + CONTROL[@type][:control_end])].pack("H*").force_encoding(Encoding::BINARY)

      puts "color_command:"
      puts color_command.to_s
      #
      @commands.push(control_command)
    end

    return @commands
  end

end
