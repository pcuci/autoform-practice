@Topics = new Mongo.Collection('topics')

@radioOptions = [
  value: "opt1"
  label: "Bit Good\ndt1 whoaos dt1 whoaos dfa"
,
  value: "opt2"
  label: "Fairly Good"
,
  value: "opt3"
  label: "Betterthanaveragealways\nand sf ad"
,
  value: "opt4"
  label: "Great!\ndfa gad df ad mand sf\nad mand sf ad small"
]

@radioOptionsIrritable = [
  value: "opt1"
  label: "Irritable\ndt1 whoaos dt1 whoaos dfa"
,
  value: "opt2"
  label: "Fairly Irratable"
,
  value: "opt3"
  label: "Wow Irrated\nand sf ad"
,
  value: "opt4"
  label: "Irritating!\ndfa gad df ad mand sf\nad mand sf ad small"
,
  value: "opt5"
  label: "Infuriating\ndfa gad df ad mand sf\nad mand sf ad small"
,
  value: "opt6"
  label: "Blown away\ndfa gad df ad mand sf\nad mand sf ad small"
]

Topics.attachSchema new SimpleSchema(
  name:
    type: String
    label: "Name"
  importance:
    type: Number
    label: "Importance"
    autoform:
      type: "uncheckable-range"
      min: 0
      max: 100
  stars:
    type: String
    label: "Stars"
    autoform:
      type: "range"
      min: 0
      max: 50
  tags:
    type: [String]
    label: "Tags"
    autoform:
      type: "text"
  feelingGood:
    type: String
    label: "Good\nor great\nor fantastic"
    allowedValues: _.pluck(radioOptions, 'value')
    optional: true
    autoform:
      type: "select-uncheckable-radio"
      options: ->
        _.map radioOptions, (option) ->
          {
            label: option.label
            value: option.value
          }
  feelingAnxious:
    type: String
    label: "Anxious"
    allowedValues: _.pluck(radioOptions, 'value')
    optional: true
    autoform:
      type: "select-uncheckable-radio"
      options: ->
        _.map radioOptions, (option) ->
          {
            label: option.label
            value: option.value
          }
  feelingIrritated:
    type: String
    label: "Irritated"
    allowedValues: _.pluck(radioOptionsIrritable, 'value')
    optional: true
    autoform:
      type: "select-uncheckable-radio"
      options: ->
        _.map radioOptionsIrritable, (option) ->
          {
            label: option.label
            value: option.value
          }
  created:
    type: Date
    label: "Created At"
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  stressors:
    type: [Object]
    label: "Stressors"
    optional: true
  "stressors.$.name":
    type: String
    optional: true
  "stressors.$.type":
    type: String
    optional: true
  "stressors.$.intensity":
    type: String
    label: "How much afraid?"
    optional: true
    allowedValues: options.stressors
    autoform:
      type: "select-uncheckable-radio"
      options: ->
        _.map options.stressors, (option) ->
          {
            label: dictionary.get("charts.options." + option)
            value: option
          }
  updated:
    type: Date
    label: "Updated At"
    autoValue: ->
      new Date()
  authorId:
    type: String
    regEx: SimpleSchema.RegEx.Id
)

if Meteor.isServer
  Topics.allow
    insert: (userId, doc) ->
      true
    update: (userId, doc, fieldNames, modifier) ->
      true
    remove: (userId, doc) ->
      true

  Topics.deny
    insert: (userId, doc) ->
      false
    update: (userId, doc, fieldNames, modifier) ->
      false
    remove: (userId, doc) ->
      false
