class Featurette
  @version = "1.2.0"

  @registered_features = {}
  @featurettes = {}
  @featurettes_counter = 0

  # Registers a new featurette.
  @register: (name, klass) ->
    if @registered_features[name]?
      false
    else
      @registered_features[name] = klass
      true

  @load: (matchClass = "featurette") ->
    for element in $(".#{matchClass}")
      featurette = element.getAttribute("data-featurette")

      klass = @registered_features[featurette]

      throw "Unknown featurette #{featurette}" unless klass

      # Set up the automatic id for the element
      id = element.id
      if not id? or id is ""
        id = "featurette-#{@featurettes_counter}"
        element.id = id

      obj = new klass(element)

      @featurettes[id] = obj
      @featurettes_counter += 1

  # Returns the featurette object attached to this element
  @get: (id) ->
    @featurettes[id]

window.Featurette = Featurette
