require "libusb"

class AwMouseDriver
  ID_VENDOR = 0x4ca
  ID_PRODUCT = 0x00a5
  DEVICE_ENDPOINT_IN = 0x03

  @usb = nil
  @handle = nil
  @device = nil

  def initialize(debug_usb=0)
    @usb = LIBUSB::Context.new
    @usb.debug = debug_usb
  end

  def connect_device
    @device = @usb.devices(idVendor: ID_VENDOR, idProduct: ID_PRODUCT).first
    @handle = @device.open
    @handle.auto_detach_kernel_driver = true
    @handle.set_configuration(1) rescue nil
    @handle.claim_interface(1)
  end

  def disconnect_device
    @handle.release_interface(1)
    @handle.close

    @device = nil
    @handle = nil
  end

  def send_data(data)
	  response = @handle.interrupt_transfer(
	    endpoint: DEVICE_ENDPOINT_IN,
	    dataOut: data,
	    timeout: 1000
	  )

	  p response
  end

end
