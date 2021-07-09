import React, {useState} from 'react'
import QueryBlockEditor from './QueryBlockEditor'
import {SimpleSchema2Bridge as Bridge} from 'uniforms-bridge-simple-schema-2'
import { Segment } from 'semantic-ui-react'
import {getNewBlock} from './queryEditorHelpers'
import PartIndex from './PartIndex'
import _ from 'lodash'
# import './queryEditor.styl'

import testRule from './testRule'

export default QueryEditor = React.memo ({schema, rule, path, onChange}) ->

  bridge = new Bridge schema, ->

  path ?= ''
  rule ?= getNewBlock {bridge, path, type: 'logicBlock'}

  deleteMarkedPartsOf = (theRule) ->
    traverse = (part) ->
      if part.type is 'block'
        _.remove part.content, (child) -> child.delete
        part.content.forEach traverse
    traverse theRule

  handleMove = ({start, end, bottom, copy}) ->
    theRule = _(rule).cloneDeep()
    movingPart = start.partOf theRule
    movingPartClone = _(movingPart).cloneDeep()
    target = end.partOf theRule
    targetsParent = end.parent().partOf theRule
    if target.type is 'sentence' or bottom
      targetsParent.content.push movingPartClone
    else
      target.content.unshift movingPartClone
    unless copy
      movingPart.delete = true
      deleteMarkedPartsOf theRule
    onChange theRule


  <div className="query-editor">
    <QueryBlockEditor
      rule={rule}
      partIndex={new PartIndex()}
      bridge={bridge}
      path={path}
      onChange={onChange}
      onMove={handleMove}
      isRoot={true}
    />
  </div>
