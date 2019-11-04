require "./aw_mouse_driver.rb"
require "./aw_mouse_command.rb"

commands = AwMouseCommand.new(1, [[0xFF, 0xFF, 0x00], [0x00, 0xFF, 0xFF], [0xFF, 0x00, 0xFF]]).prepare_commands

d = AwMouseDriver.new(0)
d.connect_device
commands.each do |command|
  puts "SENDING COMMAND"
  d.send_data(command)
end
d.disconnect_device
