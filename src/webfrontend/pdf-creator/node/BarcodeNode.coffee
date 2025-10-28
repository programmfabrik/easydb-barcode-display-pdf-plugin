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

		[objectName, fieldName = objectName] = data.field_name.split(".")

		if fieldName.startsWith("_")
			barcodeData = object[fieldName]
		else
			barcodeData = object[objectName][fieldName]

		# add prefix and suffix if given
		if data?.code_prefix
			barcodeData = data.code_prefix + barcodeData
		if data?.code_suffix
			barcodeData = barcodeData + data.code_suffix

		if not barcodeData
			return

		barcode = new ez5.Barcode
			mode: "pdf"
			type: data.code_type
			barcode_type: data.barcode_type

		barcode.render(barcodeData)

		barcodeWidth = data.barcode_width or "100%"
		CUI.dom.setStyle(barcode.DOM, width: barcodeWidth)
		return barcode.DOM

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
