<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="listaDistritosSistema" scope="request" type="java.util.ArrayList<java.lang.String>"/>
<jsp:useBean id="noValidMail" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="noValidRUC" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="camposNoLlenados" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="datosIngresados" scope="request" type="com.example.telefarma.beans.BFarmaciasAdmin" class="com.example.telefarma.beans.BFarmaciasAdmin"/>

<!DOCTYPE html>
<html lang="en">
    <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
            <title>Telefarma - Registrar Farmacia</title>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/res/bootstrap/css/bootstrap.min.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/estilos.css">
            <script src="https://kit.fontawesome.com/5733880de3.js" crossorigin="anonymous"></script>
    </head>
    <body>

        <%
            String valorNombre = "";
            String valorRUC = "";
            String valorDistrito = "";
            String valorDireccion = "";
            String valorCorreo = "";
            if (datosIngresados != null) {
            valorNombre = "value='" + datosIngresados.getNombreFarmacia() + "'";
            valorRUC = "value='" + datosIngresados.getRUCFarmacia() + "'";
            valorDistrito = "value='" + datosIngresados.getDistritoFarmacia() + "'";
            valorDireccion = "value='" + datosIngresados.getDireccionFarmacia() + "'";
            valorCorreo = "value='" + datosIngresados.getEmailFarmacia() + "'";
            }%>

        <section class="vh-100 ">
            <div class="container py-4 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-header" style="background-color: rgba(245, 127, 0, 0.87); color: white;">
                                <h4 class="my-2">Registrar farmacia</h4>
                            </div>
                            <div class="card-body p-4 p-md-5">
                                <form method="POST" action="<%=request.getContextPath()%>/PharmacyAdminServlet?action=registrar">

                                    <div class="row mb-3">

                                        <div class="col-md-6">
                                            <div class="form-outline">
                                                <label class="form-label" for="farmaName">Nombre</label>
                                                <input type="text" name="nombre" id="farmaName" class="form-control" <%=valorNombre%>
                                                       placeholder="Ingrese nombre de la farmacia"/>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-outline">
                                                <label class="form-label" for="farmaMail">Correo</label>
                                                <input type="email" name="correo" id="farmaMail" class="form-control" <%=valorCorreo%>
                                                       placeholder="Ingrese el mail de la farmacia"/>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row mb-3">

                                        <div class="col-md-6">
                                            <div class="form-outline">
                                                <label class="form-label" for="farmaDireccion">Dirección</label>
                                                <input type="text" name="direccion" id="farmaDireccion" class="form-control" <%=valorDireccion%>
                                                       placeholder="Ingrese la dirección de la farmacia"/>
                                            </div>
                                        </div>

                                        <div class="col-md-6">

                                            <div class="form-outline">
                                                <label class="form-label" for="farmaDistrict">Distrito</label>
                                                <select class="form-select" name="distrito" id="farmaDistrict">
                                                    <option value="" disabled selected>Ingrese el distrito de la farmacia</option>
                                                    <%
                                                    for (String distrito : listaDistritosSistema){
                                                    %>
                                                    <option value="<%=distrito%>"><%=distrito%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row mb-3">

                                        <div class="col-md-6 mb-4 pb-2">
                                            <div class="form-outline">
                                                <label class="form-label" for="farmaRUC">RUC</label>
                                                <input type="text" name="ruc" id="farmaRUC" class="form-control" <%=valorRUC%>
                                                       placeholder="Ingrese el RUC de la farmacia"/>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row row-cols-3 justify-content-center">
                                        <input class="btn btn-tele" type="submit" id="" value="Registrar farmacia"/>
                                    </div>
                                    <br>
                                    <%if (noValidMail == 1) { %>
                                    <div class="alert alert-danger" role="alert">
                                        El correo que ha ingresado ya esta en uso
                                    </div>
                                    <%}
                                    if (noValidRUC == 1) { %>
                                    <div class="alert alert-danger" role="alert">
                                        El RUC que ha ingresado ya esta en uso
                                    </div>
                                    <%}
                                    if (camposNoLlenados == 1) { %>
                                    <div class="alert alert-danger" role="alert">
                                        Debe llenar todos los campos
                                    </div>
                                    <% } %>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="<%=request.getContextPath()%>/res/bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>
