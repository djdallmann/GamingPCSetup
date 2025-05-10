pnputil /remove-device /class "Mouse" /subtree
pnputil /remove-device /class "Keyboard" /subtree
pnputil /remove-device /class "HIDClass" /subtree
pnputil /remove-device /class "USBDevice" /subtree
pnputil /remove-device /class "USB" /subtree
timeout 15
pnputil.exe /scan-devices
