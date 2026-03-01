Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- FUNCIONES DE GESTION DE CONFIGURACION ---
$configFile = "config.ini"

function Get-IniValue {
    param($key, $default)
    if (Test-Path $configFile) {
        $line = Get-Content $configFile | Select-String -Pattern "^$key\s*=\s*(.*)"
        if ($line) { return $line.Matches.Groups[1].Value.Trim() }
    }
    return $default
}

function Set-IniValue {
    param($key, $value)
    if (!(Test-Path $configFile)) { return }
    $content = Get-Content $configFile
    $newContent = foreach ($line in $content) {
        if ($line -match "^$key\s*=") { "$key = $value" }
        else { $line }
    }
    $newContent | Set-Content $configFile
}

# --- VENTANA PRINCIPAL ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "Panel Avanzado - AI Face Anonymizer"
$form.Size = New-Object System.Drawing.Size(550, 750)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::WhiteSmoke

$fontTitle = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$fontSection = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$fontDesc = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Italic)

# Cabecera
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "Configuracion de Anonimizacion"
$lblTitle.Font = $fontTitle
$lblTitle.Location = New-Object System.Drawing.Point(0, 20)
$lblTitle.Size = New-Object System.Drawing.Size(550, 40)
$lblTitle.TextAlign = "MiddleCenter"
$lblTitle.ForeColor = [System.Drawing.Color]::DarkSlateBlue
$form.Controls.Add($lblTitle)

# --- SECCION 1: IA Y MODELO ---
$groupIA = New-Object System.Windows.Forms.GroupBox
$groupIA.Text = "Ajustes de Inteligencia Artificial"
$groupIA.Location = New-Object System.Drawing.Point(25, 70)
$groupIA.Size = New-Object System.Drawing.Size(485, 160)
$groupIA.Font = $fontSection
$form.Controls.Add($groupIA)

# Modelo
$lblM = New-Object System.Windows.Forms.Label
$lblM.Text = "Tamano del Modelo (Velocidad vs Precision):"
$lblM.Location = New-Object System.Drawing.Point(15, 30)
$lblM.Size = New-Object System.Drawing.Size(300, 20)
$groupIA.Controls.Add($lblM)

$cmbModel = New-Object System.Windows.Forms.ComboBox
$cmbModel.Items.AddRange(@("n", "s", "m", "l", "x"))
$cmbModel.SelectedItem = Get-IniValue "model_size" "x"
$cmbModel.Location = New-Object System.Drawing.Point(15, 50)
$cmbModel.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$groupIA.Controls.Add($cmbModel)

$lblMDesc = New-Object System.Windows.Forms.Label
$lblMDesc.Text = "n: Muy rapido (menos preciso) | x: Muy lento (maxima precision)"
$lblMDesc.Location = New-Object System.Drawing.Point(15, 75)
$lblMDesc.Size = New-Object System.Drawing.Size(450, 15)
$lblMDesc.Font = $fontDesc
$groupIA.Controls.Add($lblMDesc)

# Confianza
$lblC = New-Object System.Windows.Forms.Label
$lblC.Text = "Umbral de Confianza (0.1 - 0.9):"
$lblC.Location = New-Object System.Drawing.Point(15, 100)
$lblC.Size = New-Object System.Drawing.Size(200, 20)
$groupIA.Controls.Add($lblC)

$txtConf = New-Object System.Windows.Forms.TextBox
$txtConf.Text = Get-IniValue "min_confidence" "0.2"
$txtConf.Location = New-Object System.Drawing.Point(15, 120)
$groupIA.Controls.Add($txtConf)

$lblCDesc = New-Object System.Windows.Forms.Label
$lblCDesc.Text = "Si detecta caras que no son, sube este valor (ej. 0.5)"
$lblCDesc.Location = New-Object System.Drawing.Point(220, 123)
$lblCDesc.Size = New-Object System.Drawing.Size(250, 15)
$lblCDesc.Font = $fontDesc
$groupIA.Controls.Add($lblCDesc)

# --- SECCION 2: PIXELADO Y ESTILO ---
$groupStyle = New-Object System.Windows.Forms.GroupBox
$groupStyle.Text = "Ajustes de Pixelado"
$groupStyle.Location = New-Object System.Drawing.Point(25, 240)
$groupStyle.Size = New-Object System.Drawing.Size(485, 160)
$groupStyle.Font = $fontSection
$form.Controls.Add($groupStyle)

# Blocks
$lblB = New-Object System.Windows.Forms.Label
$lblB.Text = "Intensidad (Num. bloques):"
$lblB.Location = New-Object System.Drawing.Point(15, 30)
$lblB.Size = New-Object System.Drawing.Size(200, 20)
$groupStyle.Controls.Add($lblB)

$txtBlocks = New-Object System.Windows.Forms.TextBox
$txtBlocks.Text = Get-IniValue "blocks_across" "10"
$txtBlocks.Location = New-Object System.Drawing.Point(15, 50)
$groupStyle.Controls.Add($txtBlocks)

$lblBDesc = New-Object System.Windows.Forms.Label
$lblBDesc.Text = "Valores bajos (5-8) = Pixelado agresivo | Altos (20+) = Mas detalle"
$lblBDesc.Location = New-Object System.Drawing.Point(15, 75)
$lblBDesc.Size = New-Object System.Drawing.Size(450, 15)
$lblBDesc.Font = $fontDesc
$groupStyle.Controls.Add($lblBDesc)

# Padding
$lblP = New-Object System.Windows.Forms.Label
$lblP.Text = "Margen extra (Padding):"
$lblP.Location = New-Object System.Drawing.Point(15, 100)
$lblP.Size = New-Object System.Drawing.Size(200, 20)
$groupStyle.Controls.Add($lblP)

$txtPad = New-Object System.Windows.Forms.TextBox
$txtPad.Text = Get-IniValue "box_padding" "0.25"
$txtPad.Location = New-Object System.Drawing.Point(15, 120)
$groupStyle.Controls.Add($txtPad)

$lblPDesc = New-Object System.Windows.Forms.Label
$lblPDesc.Text = "0.25 = Tapa un 25% mas alrededor de la cara detectada."
$lblPDesc.Location = New-Object System.Drawing.Point(220, 123)
$lblPDesc.Size = New-Object System.Drawing.Size(250, 15)
$lblPDesc.Font = $fontDesc
$groupStyle.Controls.Add($lblPDesc)

# --- SECCION 3: VIDEO Y RENDIMIENTO ---
$groupVideo = New-Object System.Windows.Forms.GroupBox
$groupVideo.Text = "Calidad de Video y Resolucion"
$groupVideo.Location = New-Object System.Drawing.Point(25, 410)
$groupVideo.Size = New-Object System.Drawing.Size(485, 160)
$groupVideo.Font = $fontSection
$form.Controls.Add($groupVideo)

# CRF
$lblCRF = New-Object System.Windows.Forms.Label
$lblCRF.Text = "Compresion Video (CRF 0-51):"
$lblCRF.Location = New-Object System.Drawing.Point(15, 30)
$lblCRF.Size = New-Object System.Drawing.Size(200, 20)
$groupVideo.Controls.Add($lblCRF)

$txtCRF = New-Object System.Windows.Forms.TextBox
$txtCRF.Text = Get-IniValue "video_crf" "23"
$txtCRF.Location = New-Object System.Drawing.Point(15, 50)
$groupVideo.Controls.Add($txtCRF)

$lblCRFDesc = New-Object System.Windows.Forms.Label
$lblCRFDesc.Text = "18: Calidad alta | 23: Estandar | 28: Calidad baja"
$lblCRFDesc.Location = New-Object System.Drawing.Point(200, 53)
$lblCRFDesc.Size = New-Object System.Drawing.Size(270, 15)
$lblCRFDesc.Font = $fontDesc
$groupVideo.Controls.Add($lblCRFDesc)

# ImgSize
$lblS = New-Object System.Windows.Forms.Label
$lblS.Text = "Resolucion de Escaneo (IA):"
$lblS.Location = New-Object System.Drawing.Point(15, 100)
$lblS.Size = New-Object System.Drawing.Size(200, 20)
$groupVideo.Controls.Add($lblS)

$txtSize = New-Object System.Windows.Forms.TextBox
$txtSize.Text = Get-IniValue "img_size" "1280"
$txtSize.Location = New-Object System.Drawing.Point(15, 120)
$groupVideo.Controls.Add($txtSize)

$lblSDesc = New-Object System.Windows.Forms.Label
$lblSDesc.Text = "1280 recomendado. Reduce para mayor velocidad en 4K."
$lblSDesc.Location = New-Object System.Drawing.Point(15, 145)
$lblSDesc.Size = New-Object System.Drawing.Size(450, 15)
$lblSDesc.Font = $fontDesc
$groupVideo.Controls.Add($lblSDesc)

# --- BOTONES DE ACCION ---
$btnRun = New-Object System.Windows.Forms.Button
$btnRun.Text = "INICIAR PROCESAMIENTO"
$btnRun.Location = New-Object System.Drawing.Point(100, 600)
$btnRun.Size = New-Object System.Drawing.Size(350, 50)
$btnRun.BackColor = [System.Drawing.Color]::LightGreen
$btnRun.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$btnRun.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnRun.Add_Click({
    Set-IniValue "model_size" $cmbModel.SelectedItem
    Set-IniValue "min_confidence" $txtConf.Text
    Set-IniValue "blocks_across" $txtBlocks.Text
    Set-IniValue "box_padding" $txtPad.Text
    Set-IniValue "video_crf" $txtCRF.Text
    Set-IniValue "img_size" $txtSize.Text
    
    Start-Process powershell -ArgumentList "-NoExit", "-Command", "python pixelado_caras_automatico.py"
    $form.Close()
})
$form.Controls.Add($btnRun)

$btnFolder = New-Object System.Windows.Forms.Button
$btnFolder.Text = "Abrir Carpeta de Resultados"
$btnFolder.Location = New-Object System.Drawing.Point(100, 660)
$btnFolder.Size = New-Object System.Drawing.Size(350, 30)
$btnFolder.Add_Click({
    if (Test-Path "anonymized") { Invoke-Item "anonymized" }
})
$form.Controls.Add($btnFolder)

$form.ShowDialog()
