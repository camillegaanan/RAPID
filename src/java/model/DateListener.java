/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.servlet.*;
/**
 *
 * @author Trixcie
 */
public class DateListener implements ServletContextListener{
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext sc = sce.getServletContext();
//        Date d = new Date();
        sc.setAttribute("date", new DateObject());
    }
    @Override
    public void contextDestroyed(ServletContextEvent sc) {}
}
