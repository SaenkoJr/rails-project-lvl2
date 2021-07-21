const { environment } = require('@rails/webpacker')
const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
  $: 'jquery',
  jquery: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', '@popperjs/core', 'default']
}))

module.exports = environment
