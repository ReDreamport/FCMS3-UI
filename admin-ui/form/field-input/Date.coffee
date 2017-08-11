FF = F.Form

FF.Date = {
    buildField: (form, fieldName, $fieldInputSlot, entityInitValue) ->
        FF.buildNormalField(form, fieldName, $fieldInputSlot, entityInitValue, FF.Date.buildFieldItem)

    buildFieldItem: (form, fieldMeta, itemValue)->
        $date = $ FT.Date({field: fieldMeta, fClass: form.fClass, value: itemValue})
        F.enableDatePicker($date.find('input.date-picker'))
        $date

    getInput: (form, fieldName)->
        $field = FF.get$field(form, fieldName)
        values = []
        $field.find(".fw-field-item-input.#{form.fClass}").each ->
            $this = $(this)
            date = $this.find('.date-picker:first').val()

            if date
                m = moment(date, ["YYYY-M-D"], true)
                values.push(m.valueOf())
        FF.normalizeSingleOrArray values, form.entityMeta.fields[fieldName].multiple
}
