function import_local_js(code::AbstractString)

	code_js = 
		try
		Main.PlutoRunner.publish_to_js(code)
	catch
		repr(code)
	end
	
	HypertextLiteral.JavaScript(
		"""
		await (() => {
		
		window.created_imports = window.created_imports ?? new Map()
		
		let code = $(code_js)
		if(created_imports.has(code)){
			return created_imports.get(code)
		} else {
			let blob_promise = new Promise((resolve, reject) => {
        		const reader = new FileReader()
        		reader.onload = async () => {
					try {
						resolve(await import(reader.result))
					} catch(e) {
						reject()
					}
				}
				reader.onerror = () => reject()
				reader.onabort = () => reject()
        		reader.readAsDataURL(
				new Blob([code], {type : "text/javascript"}))
    		})
			created_imports.set(code, blob_promise)
			return blob_promise
		}
		})()
		"""
	)
end

function bundle_ES6(input_file_path::AbstractString; 
        import_map_path::Union{AbstractString,Nothing}=nothing,
        no_remote::Bool=false,
    )::String
    
    @info "Bundling ES6 file:" input_file_path
    
    run_command(
        `$(deno()) 
        bundle 
        $(
            import_map_path === nothing ? () : 
            ("--import-map",import_map_path)
        )
        $(
            no_remote ? "--no-remote" : ()
        )
        $(input_file_path)
        `
    )
end


function run_command(c::Cmd)::String
	error_file = tempname()
    try
		read(pipeline(c, stderr=error_file), String)
	catch e
		if e isa ProcessFailedException
            throw(ErrorException(
                "Failed to run $(c): \n\n$(read(error_file, String))"))
		else
			rethrow(e)
		end
	end
end


function import_local_css(code::AbstractString)
    @htl("""
    <script>
    const code = $(try
        Main.PlutoRunner.publish_to_js(code)
    catch
        code
    end)

    // This map contains previously generated object URLs as optimization.
    window.__pluto_created_css_urls = window.__pluto_created_css_urls ?? new Map()

    let url;

    if(__pluto_created_css_urls.has(code)){
        url = __pluto_created_css_urls.get(code)
    } else {
        const blob = new Blob([code], {type : "text/css"})
        url = URL.createObjectURL(blob)
        __pluto_created_css_urls.set(code, url)
    }

    const link = document.createElement("link")
    link.rel = "stylesheet"
    link.href = url

    return link
    </script>
    """)
end