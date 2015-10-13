Template.TopicEdit.events {
  'click button': ->
    $('form#topicEditForm').submit()
}

Template.TopicEdit.helpers {
  beforeRemove: ->
    (collection, id) ->
      doc = collection.findOne(id)
      if confirm("Really delete topic?")
        @remove()
        Router.go "topics"
}

# TopicEdit: Lifecycle Hooks
Template.TopicEdit.created = ->

Template.TopicEdit.rendered = ->

Template.TopicEdit.destroyed = ->
