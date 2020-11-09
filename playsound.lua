local ffi = require("ffi")

--[=====[ 
> Winmm.dll
> 
> // https://docs.microsoft.com/en-us/windows/desktop/WinProg/windows-data-types
> BOOL PlaySound(
>    LPCTSTR pszSound, //A pointer to a constant null-terminated string of 8-bit Windows (ANSI) characters. 
>    HMODULE hmod, //pointer ....64bit(always, said one post)..or just assume 64bit :F
>    DWORD   fdwSound // A 32-bit unsigned integer. The range is 0 through 4294967295 decimal.
> );
> 
> 1pszSound
> A string that specifies the sound to play. The maximum length, including the null terminator, is 256 characters. If this parameter is NULL
> 
> 2 NULL
> 
> 3 flags
> #define SND_ASYNC 0x0001 /* play asynchronously */
> #define SND_NODEFAULT       0x0002  /* silence (!default) if sound not found */
> #define SND_FILENAME    0x00020000L /* name is file name */
--]=====]
ffi.cdef[[
    bool PlaySound(const char *pszSound, void *hmod, uint32_t fdwSound);
]]
local winmm = ffi.load("Winmm")

local function playsound(filepath)
    winmm.PlaySound(filepath, nil, 0x00020003)
    -- control volume: https://stackoverflow.com/questions/2302841/win32-playsound-how-to-control-the-volume
end

return {
    playsound = playsound,
}
