$global:esc=''
$global:prompt='[1;33mPS$($PSVersionTable.PSVersion.Major) [32m$([Environment]::UserName)@$([Environment]::MachineName)[22;37m:[1;36m$pwd[m'

function global:prompt
{
    $ExecutionContext.InvokeCommand.ExpandString($prompt) + ('>'*($nestedPromptLevel+1)) + " "
}
function global:Switch-PromptInversion
{
    if ($global:prompt.StartsWith('[7m')) #[m
    {
        $global:prompt = $prompt.Substring(4)
    }
    else
    {
        $global:prompt = "[7m$prompt" #[m
    }
}
function global:Switch-PromptBold
{
    if ($global:prompt.Contains('[1')) #[m
    {
        $global:prompt = $prompt -replace '\[1;(\d+)m','[$1m' #[m
    }
    else
    {
        $global:prompt = $prompt -replace '\[(\d+)m', '[1;$1m' #[m
    }
}
if ((New-PSDrive -Name % -PSProvider FileSystem -Root $HOME -Description 'Driver for Home path' -ErrorAction Ignore) -and ($pwd.Path -eq $HOME)) { Set-Location %: }
