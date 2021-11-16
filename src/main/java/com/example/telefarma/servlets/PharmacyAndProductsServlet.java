package com.example.telefarma.servlets;

import com.example.telefarma.daos.InfoFarmaciayProductosDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "PharmacyandProductsServlet", value = "/PharmacyAndProductsServlet")
public class PharmacyAndProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int pagina = request.getParameter("pagina") == null ? 0 : Integer.parseInt(request.getParameter("pagina"));
        String busqueda = request.getParameter("busqueda") == null ? "" : request.getParameter("busqueda");
        int idPharmacy = Integer.parseInt(request.getParameter("idPharmacy"));
        int limiteProductos = 16;

        InfoFarmaciayProductosDao infoFarmaciayProductos = new InfoFarmaciayProductosDao();
        request.setAttribute("idFarma",idPharmacy);
        request.setAttribute("infoFarmacia",infoFarmaciayProductos.datosFarmacia(idPharmacy));
        request.setAttribute("productosDeLaFarmacia", infoFarmaciayProductos.listaProductosFarmacia(pagina, busqueda,idPharmacy,limiteProductos));


        request.setAttribute("pagActual",pagina);
        int pagTotales= (int)Math.ceil((double)infoFarmaciayProductos.cantidadProductos(busqueda,idPharmacy)/limiteProductos);
        request.setAttribute("pagTotales",pagTotales);

        RequestDispatcher view = request.getRequestDispatcher("/cliente/productosFarmacia.jsp");
        view.forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        switch(request.getParameter("action")) {
            case "buscar":
                String busqueda = request.getParameter("busqueda") == null ? "" : request.getParameter("busqueda");
                int idPharmacy = Integer.parseInt(request.getParameter("idPharmacy"));
                response.sendRedirect(request.getContextPath()+"/PharmacyAndProductsServlet?busqueda="+busqueda+"&idPharmacy="+idPharmacy);
                break;

            default:
                break;
        }
    }
}
