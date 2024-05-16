// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";

// ActiveStorage Direct Upload
import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();

import "trix";
import "@rails/actiontext";

// Stimulus
import "./controllers";

import * as bootstrap from "bootstrap";
