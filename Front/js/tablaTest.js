$select = document.querySelector("#select");

$(document).ready(function() {

    consutarTablaTest();

});

function consutarTablaTest() {
    var opcion = "SEL";
    var estado = 'ACTIVO';
    $.ajax({
        type: "POST",
        url: "http://localhost:38876/api/TblPruebaTest/consultaTablaTest",
        data: JSON.stringify({
            opcion: opcion 
        }),
        processData: false,
        contentType: 'application/json; charset=utf-8',
        beforeSend: function() {
            $("#dialogo_loading").show();
        },
        success: function(data) {
            $("#dialogo_loading").hide();
            if (data.codigoError == 0) {
                $('#tabla > tbody').empty();
                $.each(data.root[0], function(i, item) {
                    
                    var row = '<tr id="' + i + '">' +
                        '<td id="codig">' + item.id + '</td>' +
                        "<td>" + item.titulo + "</td>" +
                        "<td>" + item.descripcion + "</td>" +
                        "<td>" + item.fechacreacion + "</td>" +
                        "<td>" + item.fechavencimiento + "</td>" +
                        "<td>" + item.completada + "</td>" + 
                        '<td><button type="button" onclick="EditarTablaTest(this)" data-bs-target="#dialog" class="btn btn-primary"><i class="fa fa-pencil"></i> Editar</button></td>' +
                        '<td><button type="button" onclick="eliminar(this)" class="btn btn-primary"><i class="fa fa-trash"></i> Eliminar</button></td>' +
                        "</tr>";
                    $("#tabla>tbody").append(row);
                });
            } else {
                alert('Error ' + data.mensajeError);
            }
        },
        error: function(xhr, status) {
            $("#dialogo_loading").hide();
            alert('Error, Ocurrio un problema con el servidor');
        },
    });
}

function eliminar(usuario) {
    var opcion = "ELIM";
    var index = $(usuario).closest("tr").index();
    let obtenerFila = document.getElementById(index);
    let elementosFila = obtenerFila.getElementsByTagName("td");
    $.ajax({
        type: "POST",
        url: "http://localhost:38876/api/TblPruebaTest/mantenimientoTablaTest",
        data: JSON.stringify({
            opcion: opcion,
            id: elementosFila[0].innerHTML,
            titulo: '',
            descripcion: '',
            fechaCreacion: '',
            fechaVencimiento: '', 
            completada: '' 
        }),
        contentType: 'application/json; charset=utf-8',
        success: function(data) {
            if (data.codigoError == 0) {
                alert('Exito ' + data.mensajeError);
                consutarTablaTest();
            } else {
                alert('Error ' + data.mensajeError);
            }
        },
    });
}

function LimpiarTabla() {
    document.getElementById("txt_id").value = 0;
    document.getElementById("txt_titulo").value = '';
    document.getElementById("txt_descripcion").value = '';
    document.getElementById("txt_fechaCreacion").value = '';
    document.getElementById("txt_fechaVencimiento").value = '';
    document.getElementById("txt_completada").value = ''; 
}

function EditarTablaTest(usuario) {
    $('#dialog').modal('show');
    var exampleModal = document.getElementById('dialog');
    var modalTitle = exampleModal.querySelector('.modal-title');
    modalTitle.textContent = 'Editar tabla';
    var index = $(usuario).closest("tr").index();
    console.log(" ..." + index);
    obtenerFila = document.getElementById(index);
    elementosFila = obtenerFila.getElementsByTagName("td");
    document.getElementById("titulo_modal").value = 'Editar tabla';
    document.getElementById("txt_codigo").value = elementosFila[0].innerHTML;
    document.getElementById("txt_titulo").value = elementosFila[1].innerHTML;
    document.getElementById("txt_descripcion").value = elementosFila[2].innerHTML;
	const fc = elementosFila[3].innerHTML.split("/");
	const fv = elementosFila[4].innerHTML.split("/");
    document.getElementById("txt_fechaCreacion").value = fc[2]+"-"+fc[1]+"-"+fc[0];
    document.getElementById("txt_fechaVencimiento").value = fv[2]+"-"+fv[1]+"-"+fv[0];
    document.getElementById("txt_completada").value = elementosFila[5].innerHTML;  
}

function NuevoTablaTest() {
    $('#dialog').modal('show');
    var exampleModal = document.getElementById('dialog');
    var modalTitle = exampleModal.querySelector('.modal-title');
    modalTitle.textContent = 'Nuevo tabla';
    LimpiarTabla(); 

}

function guardar() {
    var opcion = "INS";
    var id = 0;
    if (document.getElementById("txt_id").value != null) {
        id = document.getElementById("txt_id").value;
    }
    var titulo = document.getElementById("txt_titulo").value;
    var descripcion = document.getElementById("txt_descripcion").value; 
    var fechaCreacion = document.getElementById("txt_fechaCreacion").value;
    var fechaVencimiento = document.getElementById("txt_fechaVencimiento").value;
    var completada = document.getElementById("txt_completada").value;  
    $.ajax({
        type: "POST",
        url: "http://localhost:38876/api/TblPruebaTest/mantenimientoTablaTest",
        data: JSON.stringify({
            opcion: opcion,
            id: id,
            titulo: titulo,
            descripcion: descripcion,
            fechaCreacion: fechaCreacion,
            fechaVencimiento: fechaVencimiento,
            completada: completada 
        }),
        beforeSend: function() {
            $("#dialogo_loading").show();
        },
        contentType: 'application/json; charset=utf-8',
        success: function(data) {
            $("#dialogo_loading").hide();

            if (data.codigoError == 0) {
                alert('Exito ' + data.mensajeError);
                $('#dialog').modal('hide');
                consutarTablaTest();
            } else {
                alert('Error ' + data.mensajeError);
            }
        },
        error: function(xhr, status) {
            $("#dialogo_loading").hide();
            alert('Error, Ocurrio un problema con el servidor');
        },
    });
}
 

 

 

 