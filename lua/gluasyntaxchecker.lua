editor1.AnnotationVisible = ANNOTATION_BOXED
editor2.AnnotationVisible = ANNOTATION_BOXED

npp.AddEventHandler("OnSave", function(filename, bufferid)
    if npp:GetExtPart() ~= ".lua" then return false end

    editor:AnnotationClearAll()

    -- Try to compile the lua code
    local _, err = loadstring(editor:GetText(0, editor.Length), npp:GetFileName(), "t")
 
    -- See if it worked
    if err == nil then return false end

    print(err)
    local line = tonumber(err:match(":(%d+):")) - 1
    editor.AnnotationText[line] = err
    editor.AnnotationStyle[line] = STYLE_BRACELIGHT
    return false
end)

print("Syntax checker installed")