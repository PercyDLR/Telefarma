<%@ page import="com.example.telefarma.servlets.ClientServlet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="producto" scope="request" type="com.example.telefarma.beans.BProduct"/>
<jsp:useBean id="sesion" scope="session" type="com.example.telefarma.dtos.DtoSesion" class="com.example.telefarma.dtos.DtoSesion"/>
<jsp:useBean id="tamanoCarrito" scope="request" type="java.lang.Integer"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Telefarma - Buscar Producto X</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/res/bootstrap/css/bootstrap.min.css"
              type="text/css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/estilos.css" type="text/css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <script src="https://kit.fontawesome.com/5733880de3.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <%String nombreCliente = sesion.getClient().getName() + " " + sesion.getClient().getLastName();%>
        <jsp:include page="../barraSuperior.jsp">
            <jsp:param name="tipoUsuario" value="cliente"/>
            <jsp:param name="nombre" value="<%=nombreCliente%>"/>
            <jsp:param name="servletBusqueda" value="ClientServlet?action=buscarProduct"/>
            <jsp:param name="busquedaPlaceholder" value="Busca un producto"/>
            <jsp:param name="tamanoCarrito" value="<%=tamanoCarrito%>"/>
        </jsp:include>
        <!--Contenido-->
        <main class="">
            <!--Alinear cabecera con contenido-->
            <div class="card-header my-5"></div>
            <!--Detalles producto-->
            <div class="container">
                <div class="row border"
                     style="border-radius: 0.45rem; align-items: center;">
                    <!--Imagen del producto-->
                    <div class="col-md-5">
                        <div class="row text-center">
                            <img src="${pageContext.request.contextPath}/Image?idProduct=<%=producto.getIdProducto()%>"
                                 class="img-detalles">
                        </div>
                    </div>
                    <!--Info del producto-->
                    <div class="col-md-7 mt-4">
                        <!--Nombre-->
                        <h3><%=producto.getNombre()%>
                        </h3>
                        <!--Precio-->
                        <h3><span class="me-1">s/ <%=String.format("%.2f", producto.getPrecio())%></span></h3>
                        <!--Descripción-->
                        <p class="pt-1"><%=producto.getDescripcion()%>
                        </p>
                        <!--Detalles-->
                        <div class="table-responsive">
                            <table class="table table-sm table-borderless mb-0">
                                <tbody>
                                    <!--Farmacia-->
                                    <tr>
                                        <th class="ps-0 w-25" scope="row">Farmacia</th>
                                        <td>
                                            <a href="<%=request.getContextPath()%>/ClientServlet?action=farmaciaYProductos&idPharmacy=<%=producto.getIdFarmacia()%>"
                                            style="text-decoration: none; color: inherit">
                                                <%=producto.getNombreFarmacia()%>
                                            </a>

                                        </td>
                                    </tr>
                                    <!--Stock-->
                                    <tr>
                                        <th class="ps-0 w-25" scope="row">Stock</th>
                                        <td><%=producto.getStock()%>
                                        </td>
                                    </tr>
                                    <!--Receta-->
                                    <tr>
                                        <th class="ps-0 w-25" scope="row">¿Requiere receta?</th>
                                        <td><% if (producto.getRequierePrescripcion()) { %>Sí<% } else { %>No<% } %>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr>
                        <!--Cantidad y añadir carrito-->
                        <div class="table-responsive">
                            <table class="table table-sm table-borderless">
                                <tbody>
                                    <!--Label-->
                                    <tr>
                                        <td class="ps-2 p-0 w-25">Cantidad</td>
                                    </tr>
                                    <!--Botones aumentar/disminuir-->
                                    <tr>
                                        <form method="post" action="<%=request.getContextPath()%>/ClientServlet?action=addToCart&idProduct=<%=producto.getIdProducto()%>">
                                            <td class="ps-0 pt-0">
                                                <div class="d-flex">
                                                    <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()"
                                                            class="btn btn-tele" id="menos" type="button">
                                                        <i class="fas fa-minus fa-xs"></i>
                                                    </button>
                                                    <input class="form-control border-start-0 border-end-0 text-center"
                                                           type="number" style="width:46px;" id="quantity" name ="quantity"
                                                           value="1" min="1" max="<%=producto.getStock()%>"/>
                                                    <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()"
                                                            class="btn btn-tele" id="mas" type="button">
                                                        <i class="fas fa-plus fa-xs"></i>
                                                    </button>
                                                </div>
                                            </td>
                                            <!--Botón añadir a carrito-->
                                            <td class="text-end">
                                                <button type="submit" class="btn btn-tele btn-md mr-1 mb-2">
                                                    <i class="fas fa-shopping-cart"></i> Añadir al carrito
                                                </button>

                                                    <%
                                                    String alertClass = null;
                                                    String alertMssg = null;
                                                    String estadoRegistro = (String) session.getAttribute("productoEnCarrito");
                                                    if (estadoRegistro != null) {
                                                        if (!estadoRegistro.equals("")) {
                                                            switch (estadoRegistro) {
                                                                case "0":
                                                                    alertClass = "alert-success";
                                                                    alertMssg = "Producto agregado a su carrito!";
                                                                    break;
                                                                case "1":
                                                                    alertClass = "alert-danger";
                                                                    alertMssg = "Este producto ya se encuentra en su carrito";
                                                                    break;
                                                            }
                                                        }

                                                    %>
                                                <div class="alert <%=alertClass%> alert-dismissible fade show" role="alert">
                                                    <%=alertMssg%>
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                </div>
                                                <%session.removeAttribute("productoEnCarrito");
                                                } %>
                                            </td>
                                        </form>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </main>

        <!--JS-->
        <script src="${pageContext.request.contextPath}/res/bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>