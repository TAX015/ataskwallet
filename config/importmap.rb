# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin_all_from "vendor/jquery", under: "jquery"
pin_all_from "vendor/bootstrap", under: "bootstrap"
pin_all_from "vendor/jquery-easing", under: "jquery-easing"
pin_all_from "vendor/chart.js", under: "chart.js"
pin_all_from "app/javascript/demo", under: "demo"

pin "select2"
