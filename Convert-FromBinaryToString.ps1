function Convert-FromBinaryToString
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$True,Position=1,ValueFromPipeline=$True)]
        [string]$BinaryString
    )

    Begin
    {}

    Process
    {
		$chars = [System.Linq.Enumerable]::ToArray($BinaryString)
		$i = 1
		$array = @()
		$buf = ""
		foreach ($c in $chars) {
			if ($i -eq 1) {
				$buf = $c.ToString()
				$i = 2
			}
			else {
				$buf += $c.ToString()
				$array += [System.Convert]::ToInt32($buf.ToString(), 16)
				$i = 1
			}
		}

		@{
			"Default" = [System.Text.Encoding]::Default.GetString($array)
			"shift_jis" = [System.Text.Encoding]::GetEncoding("shift_jis").GetString($array)
			"euc-jp" = [System.Text.Encoding]::GetEncoding("euc-jp").GetString($array)
			"unicode" = [System.Text.Encoding]::Unicode.GetString($array)
			"UTF8" = [System.Text.Encoding]::UTF8.GetString($array)
			"UTF32" = [System.Text.Encoding]::UTF32.GetString($array)
			"UTF7" = [System.Text.Encoding]::UTF7.GetString($array)
			"ASCII" = [System.Text.Encoding]::ASCII.GetString($array)
			"BigEndianUnicode" = [System.Text.Encoding]::BigEndianUnicode.GetString($array)
		}
    }

    End
    {}
}
