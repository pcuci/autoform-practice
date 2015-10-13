Template.registerHelper "TabularTables", TabularTables

AutoForm.addHooks null,
  onError: (name, error, template) ->
    console.error name + " error:", error

topicHook =
  before:
    # Replace `formType` with the form `type` attribute to which this hook applies
    insert: (doc) ->
      # Potentially alter the doc
      #console.log("in before: insert: -- returning, doc: ")
      #console.log(doc)
      @.result(doc)
    update: (doc) ->
      # Potentially alter the doc
      #console.log("in before: update: -- returning, doc: ")
      #console.log(doc)
      @.result(doc)

  # Then return it or pass it to this.result()
  #return doc; (synchronous)
  #return false; (synchronous, cancel)
  #this.result(doc); (asynchronous)
  #this.result(false); (asynchronous, cancel)
  # The same as the callbacks you would normally provide when calling
  # collection.insert, collection.update, or Meteor.call
  after:
    insert: (error, result) ->
      #console.log("in after: insert: error: ")
      #console.log(error)
      #console.log("in after: insert: result: ")
      #console.log(result)
      Router.go("topics")
    update: (error, result) ->
      #console.log("in after: update: error: ")
      #console.log(error)
      #console.log("in after: update: result: ")
      #console.log(result)
      Router.go("topics")

  # Called when form does not have a `type` attribute
  onSubmit: (insertDoc, updateDoc, currentDoc) ->
    #console.log("in onSubmit should not have been called")
  # You must call this.done()!
  #this.done(); // submitted successfully, call onSuccess
  #this.done(new Error('foo')); // failed to submit, call onError with the provided error
  #this.done(null, "foo"); // submitted successfully, call onSuccess with `result` arg set to "foo"
    this.done()

  # Called when any submit operation succeeds
  onSuccess: (formType, result) ->
    #console.log("in onSuccess")
    #console.log("in onSuccess, formType: ")
    #console.log(formType)
    #console.log("in onSuccess, result: ")
    #console.log(result)

  # Called when any submit operation fails
  onError: (formType, error) ->

  formToDoc: (doc) ->
    #console.log("in topicHook formToDoc")
    #console.log("in topicHook formToDoc, doc:")
    #console.log(doc)
    #console.log("in topicHook formToDoc ------------------------- STARS (before): " + doc.stars)
    #console.log("typeof doc.stars: " + typeof doc.stars)
    doc.stars = if doc.stars is "0"
      "noStars"
    else if doc.stars is "1"
      "moreStars"
    #console.log("in topicHook formToDoc ------------------------- STARS (after): " + doc.stars)
    doc.tags = doc.tags.split(",") if typeof doc.tags is "string"
    doc.created ?= new Date()
    doc.updated = new Date()
    doc.authorId = Meteor.userId()
    doc

  formToModifier: (modifier) ->
    modifier

  # Called whenever `doc` attribute reactively changes, before values
  # are set in the form fields.
  docToForm: (doc, ss) ->
    #console.log("in topicHook docToForm")
    #console.log("in topicHook docToForm, doc:")
    #console.log(doc)
    #console.log("in topicHook docToForm, ss:")
    #console.log(ss)
    #console.log("in topicHook docToForm ------------------------- STARS (before): " + doc.stars)
    #console.log("typeof doc.stars: " + typeof doc.stars)
    doc.stars = if doc.stars is "noStars"
      "0"
    else if doc.stars is "moreStars"
      "1"
    #console.log("in topicHook docToForm ------------------------- STARS (after): " + doc.stars)
    doc.tags = doc.tags.join(", ") if _.isArray(doc.tags)
    doc.created ?= new Date()
    doc.updated = new Date()
    doc.authorId ?= Meteor.userId()
    doc

  # Called at the beginning and end of submission, respectively.
  # This is the place to disable/enable buttons or the form,
  # show/hide a "Please wait" message, etc. If these hooks are
  # not defined, then by default the submit button is disabled
  # during submission.
  beginSubmit: ->
    #console.log("in beginSubmit")
  endSubmit: ->
    #console.log("in endSubmit")

AutoForm.hooks
  topicNewForm: topicHook
  topicEditForm: topicHook
