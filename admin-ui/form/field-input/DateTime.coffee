FF = F.Form

FF.DateTime = {
    buildField: (form, fieldName, $fieldInputSlot, entityInitValue) ->
        FF.buildNormalField(form, fieldName, $fieldInputSlot, entityInitValue, FF.DateTime.buildFieldItem)

    buildFieldItem: (form, fieldMeta, itemValue)->
        $date = $ FT.DateTime({field: fieldMeta, fClass: form.fClass, value: itemValue})
        F.enableDatePicker($date.find('input.date-picker'))
        $date

    getInput: (form, fieldName)->
        $field = FF.get$field(form, fieldName)
        values = []
        $field.find(".fw-field-item-input.#{form.fClass}").each ->
            $this = $(this)
            date = $this.find('.date-picker:first').val()
            hour = $this.find('.date-hour:first').val()
            minute = $this.find('.date-minute:first').val()

            if date || hour || minute
                unless date && hour && minute # 要么不输入，要么全部输入
                    $this.find('.date-hour:first').focus()
                    throw "时间输入有误"

                m = moment("#{date} #{hour}:#{minute}", ["YYYY-M-D H:m"], true)
                if m.isValid()
                    values.push(m.valueOf())
                else
                    $this.find('.date-hour:first').focus()
                    throw "时间输入有误"
        FF.normalizeSingleOrArray values, form.entityMeta.fields[fieldName].multiple
}
