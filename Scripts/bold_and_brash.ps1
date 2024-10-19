# Function to disable/enable mouse input
function Set-MouseInput {
    param (
        [bool]$Enable
    )
    
    $signature = @'
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool BlockInput(bool fBlockIt);
'@
    $SetMouseInput = Add-Type -memberDefinition $signature -name "Win32MouseInput" -namespace Win32Functions -passThru
    $SetMouseInput::BlockInput(!$Enable)
}

# Disable mouse input
Set-MouseInput -Enable $false

try {
    # Start Paint
    Start-Process mspaint
    # Wait for Paint to load
    Start-Sleep -Seconds 2
    # Send keyboard shortcut to select the line tool
    $shell = New-Object -ComObject WScript.Shell
    $shell.SendKeys('%')
    $shell.SendKeys('h')
    $shell.SendKeys('l')
    # Add necessary type for mouse operations
    Add-Type -AssemblyName System.Windows.Forms
    # Function to simulate mouse actions
    function Invoke-MouseAction {
        param (
            [Parameter(Mandatory=$true)]
            [string]$Action,
            [int]$X,
            [int]$Y
        )
        
        $signature = @'
        [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
        public static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint cButtons, uint dwExtraInfo);
'@
        $SendMouseEvent = Add-Type -memberDefinition $signature -name "Win32MouseEvent" -namespace Win32Functions -passThru
        $MOUSEEVENTF_LEFTDOWN = 0x0002
        $MOUSEEVENTF_LEFTUP = 0x0004
        $MOUSEEVENTF_MOVE = 0x0001
        switch ($Action) {
            "LeftDown" { $SendMouseEvent::mouse_event($MOUSEEVENTF_LEFTDOWN, $X, $Y, 0, 0) }
            "LeftUp" { $SendMouseEvent::mouse_event($MOUSEEVENTF_LEFTUP, $X, $Y, 0, 0) }
            "Move" { $SendMouseEvent::mouse_event($MOUSEEVENTF_MOVE, $X, $Y, 0, 0) }
        }
    }
    # Function to move the mouse
    function Move-MouseTo {
        param([int]$x, [int]$y)
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
    }
    # Function to draw a line
    function Draw-Line {
        param([int]$x1, [int]$y1, [int]$x2, [int]$y2)
        Move-MouseTo $x1 $y1
        Start-Sleep -Milliseconds 50
        Invoke-MouseAction -Action "LeftDown"
        Start-Sleep -Milliseconds 50
        Move-MouseTo $x2 $y2
        Start-Sleep -Milliseconds 50
        Invoke-MouseAction -Action "LeftUp"
        Start-Sleep -Milliseconds 50
    }
    Draw-Line 600 600 800 600
    Draw-Line 800 600 800 800
    Draw-Line 800 800 600 800
    Draw-Line 600 800 600 600
    Draw-Line 600 400 800 400
    Draw-Line 800 400 800 800
    Draw-Line 800 800 600 800
    Draw-Line 600 800 600 400
    Draw-Line 800 500 1400 500
    Draw-Line 1400 500 1400 700
    Draw-Line 1400 700 800 700
}
finally {
    # Re-enable mouse input
    Set-MouseInput -Enable $true
}