module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-postcss')

  grunt.registerTask('default', ['watch'])

  grunt.initConfig
    watch:
      coffee:
        files: 'source/javascripts/*.coffee'
        tasks: ['coffee:compile', 'concat:dist', 'uglify:dist']
      sass:
        files: 'source/stylesheets/*.scss'
        tasks: ['sass:dist', 'postcss:dist']

    coffee:
      compile:
        files:
          'source/javascripts/all.js': ['source/javascripts/*.coffee']

    concat:
      options:
        separator: ';'
      dist:
        src: ['source/javascripts/vendor/jquery.js', 'source/javascripts/vendor/tether.js', 'source/javascripts/vendor/bootstrap.js', 'source/javascripts/all.js']
        dest: 'source/javascripts/all.js'

    uglify:
      dist:
        files:
          'source/javascripts/all.js': ['source/javascripts/all.js']

    sass:
      dist:
        options:
          sourcemap: 'none'
          style: 'compressed'
        files:
          'source/stylesheets/all.css': 'source/stylesheets/entry.scss'

    postcss:
      options:
        map: false
        processors: [
          require('autoprefixer')
        ]
      dist:
        src: 'source/stylesheets/all.css'
        dest: 'source/stylesheets/all.css'
