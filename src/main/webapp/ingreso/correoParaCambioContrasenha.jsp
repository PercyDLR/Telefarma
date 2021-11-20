<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="err" scope="request" type="java.lang.String"/>

<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Telefarma - Cambio de constraseña</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Andika&amp;display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/res/css/estilos.css">
  </head>

  <body>
    <section
            class="d-flex flex-grow-1 flex-shrink-1 p-4 justify-content-md-center align-items-md-center justify-content-lg-center align-items-lg-center justify-content-xl-center align-items-xl-center vh-100"
            style="min-height: auto;">
      <div class="container d-flex justify-content-center">
        <div class="card border-0 responsive-form">
          <div class="card-header card-header-tele">
            <h4 class="my-2">Cambio de contraseña</h4>
          </div>
          <div class="card-body">
            <div class="container" style="width: 70%">
              <div class="row my-4">
                <% if (err.equals("ne")) { %>
                <div class="alert alert-danger alert-dismissible fade show"
                     role="alert">
                  El correo que usted ha ingresado no está registrado
                  <button type="button" class="btn-close" data-bs-dismiss="alert"
                          aria-label="Close"></button>
                </div>
                <% } %>
                <form method="post" action="<%=request.getContextPath()%>/?action=correoParaContrasenha">
                  <div class="mb-3">
                    <input class="form-control" type="email" name="email" placeholder="Correo">
                  </div>
                  <div class="mb-3">
                    <button class="btn btn-tele d-block w-100" type="submit" style="background: var(--bs-orange); border-color: var(--bs-orange)">
                      <strong>Enviar correo</strong>
                    </button>
                  </div>
                </form>
                <a class="text-center" href="<%=request.getContextPath()%>/">Volver al Inicio de Sesión</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <script src="${pageContext.request.contextPath}/res/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
