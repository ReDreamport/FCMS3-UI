FF = F.Form

FF.JSON = {
    buildField: (form, fieldName, $fieldInputSlot, entityInitValue) ->
        FF.buildNormalField(form, fieldName, $fieldInputSlot, entityInitValue, FF.JSON.buildFieldItem)

    buildFieldItem: (form, fieldMeta, itemValue)->
        FT.JSON({field: fieldMeta, fClass: form.fClass, value: itemValue})

    getInput: (form, fieldName)->
        $field = FF.get$field(form, fieldName)
        values = []
        $field.find(".fw-field-item-input.#{form.fClass}").each ->
            v = $.trim($(this).val())
            try
                v = v && JSON5.parse(v) || null
            catch
                throw "JSON 对象无法有误 | #{fieldName}"
            values.push(v)
        FF.normalizeSingleOrArray values, form.entityMeta.fields[fieldName].multiple
}