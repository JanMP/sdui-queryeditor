import _ from 'lodash'

export getSubjectSelectOptions = ({bridge, path}) ->
  fields = bridge.getSubfields path
  pathWithName = (name) -> if path then "#{path}.#{name}" else name
  _(fields)
  .filter (name) ->
    (bridge.getType pathWithName name) not in [Array, Object]
  .map (name) ->
    #the labels generated by the Schema have corrupted umlaute
    text = bridge.getField(pathWithName name).label ? name
    value: name
    text: text
  .value()
