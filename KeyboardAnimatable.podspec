Pod::Spec.new do |s|
  s.name             = "KeybaordAnimatable"
  s.version          = "1.0"
  s.summary          = "A protocol-oriented library for performing animation when toggling keyboard."

  s.homepage         = "https://github.com/JeromeTan1997/KeyboardAnimatable"
  s.license          = 'MIT'
  s.author           = { "Jerome Tan" => "DevJerome@iCloud.com" }
  s.source           = { :git => "https://github.com/JeromeTan1997/KeyboardAnimatable.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'KeyboardAnimatable/*'

end
