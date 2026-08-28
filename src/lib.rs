use zed_extension_api as zed;

struct MlscriptExtension;

impl zed::Extension for MlscriptExtension {
    fn new() -> Self {
        Self
    }
}

zed::register_extension!(MlscriptExtension);
