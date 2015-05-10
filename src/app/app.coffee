(($) ->
  # Setup variables
  $window = $(window)
  $slide = $('.home-slide')
  $body = $('body')
  winH = $window.height()

  adjustWindow = ->
    # Init Skrollr
    s = skrollr.init(forceHeight: false)
    # Keep minimum height 768
    if winH <= 768
      winH = 768
    # Resize our slides
    $slide.height winH
    # Refresh Skrollr after resizing our sections
    s.refresh $slide
    return

  $body.imagesLoaded ->
    # using set timeout here just to show that we have a loader
    setTimeout (->
      # Fade in sections

      isSmall = ->
        matchMedia(Foundation.media_queries.small).matches and !matchMedia(Foundation.media_queries.medium).matches

      isMedium = ->
        matchMedia(Foundation.media_queries.medium).matches and !matchMedia(Foundation.media_queries.large).matches

      isLarge = ->
        matchMedia(Foundation.media_queries.large).matches

      $body.removeClass('loading').addClass 'loaded'
      $(document).foundation()
      firstContent = $('#slide-1 .slide-content')
      if isSmall() or isMedium()
        $('#slide-1 .bcg').height winH
      else if isMedium()
        firstContent.attr 'data-0-top', 'opacity: 0'
      else if isLarge()
        firstContent.attr 'data-50-top', 'opacity: 0.5'
      else
        firstContent.attr 'data-100-top', 'opacity: 0'
      if !isSmall() and !isMedium()
        # Resize sections
        adjustWindow()
      else
        # Fixing foundation's bug - topbar along with magellan
        $('.sub-nav a').click ->
          setTimeout (->
            # waiting for foundation to finish
            $('html, body').stop().animate { 'scrollTop': $(window).scrollTop() + 85 }, 1
            return
          ), 701
          return
      return
    ), 800
    return
  return
) jQuery
