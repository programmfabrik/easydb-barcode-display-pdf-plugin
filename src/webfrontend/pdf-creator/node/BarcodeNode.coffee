class ez5.PdfCreator.Node.Barcode extends ez5.PdfCreator.Node

	@getName: ->
		"barcode"

	__renderPdfContent: (opts) ->
		object = opts.object
		if not object
			return

		data = @getData()
		if not data.field_name
			return

		fieldNameSplit = data.field_name.split(".")
		barcodeData = null
		getData = (_data, fieldNames) =>
			name = fieldNames[0]
			value = _data[name]
			if CUI.util.isString(value)
				barcodeData = value
				return

			fieldNames = fieldNames.slice(1)
			if CUI.util.isPlainObject(value)
				getData(value, fieldNames)
			return
		getData(object, fieldNameSplit)

		if not barcodeData
			return

		barcode = new ez5.Barcode
			mode: "detail"
			type: data.code_type
			barcode_type: data.barcode_type
		barcode.render(barcodeData, true)

		barcodeWidth = data.barcode_width or "100%"
		img = CUI.dom.findElement(barcode.DOM, "img")
		CUI.dom.setStyle(img, width: barcodeWidth)
		return img

	__getSettingsFields: ->
		idObjecttype = @__getIdObjecttype()
		fields = ez5.BarcodeMaskSplitter.getBarcodeOptions(idObjecttype,
			store_value: "fullname"
			filter: (field) ->
				return not field.insideNested()
		)
		fields.push(
			type: CUI.Input
			name: "barcode_width"
			form: label: $$("pdf-creator.settings.barcode.barcode-width|text")
			placeholder: $$("pdf-creator.settings.barcode.barcode-width|placeholder")
		)
		return fields

	__getStyleSettings: ->
		return ["class-name"]

ez5.PdfCreator.plugins.registerPlugin(ez5.PdfCreator.Node.Barcode)