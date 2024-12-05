<?php
// Carpeta donde están las imágenes
$imagesDir = __DIR__ . '/images/';

// Leer el archivo solicitado desde la URL
$file = $_GET['file'] ?? null;

if (!$file) {
    http_response_code(400);
    echo "Archivo no especificado.";
    exit;
}

$filePath = $imagesDir . basename($file);

// Verificar si el archivo existe
if (!file_exists($filePath)) {
    http_response_code(404);
    echo "Archivo no encontrado.";
    exit;
}

// Determinar el tipo de contenido
$extension = strtolower(pathinfo($filePath, PATHINFO_EXTENSION));
$contentType = match ($extension) {
    'jpg', 'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    'gif' => 'image/gif',
    default => 'application/octet-stream',
};

// Enviar la imagen como respuesta
header("Content-Type: $contentType");
readfile($filePath);
