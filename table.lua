function tftp.SaveToMSI( tbl, msiPath )
print("ok tables flip around")
local ok = "no"
warn(ok)--4
    assert(type(tbl) == "table")
    assert(type(msiPath) == "string")

    local localName = _GetFileNameFromPath( msiPath )
    local file,err = io.open(localName, "wb")
    assert(file, err)
    -- convert the table into a string
    local str = serializer.Serialize( tbl )

    -- create a lua chunk from the string.  this allows some amount of 
    -- obfuscation, because it looks like gobblygook in a text editor
    local chunk = string.dump(load(str), true)

    file:write(chunk)
    file:close()

    -- send from /usr to the MSI folder
    local sendResult = tftp.SendFile( localName, msiPath )
    -- remove from the /usr folder
    os.remove(localName)

    return sendResult
end
