
# resolve a path based on its relative path & base, as well as checking on extensions.
path = require 'path'
fs = require 'fs'
resolve = require 'resolve'
{first} = require './async'
builtins = require './builtin'

# this is not yet the full blown resolve replacement.
resolvePath = (rspec, {dir, extensions}, cb) ->
  helper = (ext, next) ->
    filePath = path.join dir, rspec + ext
    fs.exists filePath, (exists) ->
      next null, if exists then filePath else null
  first [].concat(extensions or ['.js']), helper, cb

isCore = (rspec) ->
  builtins[rspec]?

isCoreSupported = (rspec) ->
  builtins[rspec] == true

module.exports =
  resolve: resolvePath
  sync: resolve.sync
  isCore: isCore
  isCoreSupported: isCoreSupported
    
