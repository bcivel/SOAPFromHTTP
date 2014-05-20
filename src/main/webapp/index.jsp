<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.soapfromhttp.log.MyLogger"%>
<%@page import="org.apache.log4j.Level"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.soapfromhttp.service.CallSOAP"%>


        <%
        ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
        CallSOAP soapCall = appContext.getBean(CallSOAP.class);
        
//        String envelope2 = "<ns:ExecuteSQLRequestRequest_1.0 xmlns:ns=\"http://RedouteFrance/Technical/CERBERUS/Technical/2.0/ExecuteSQLRequest/1.0\"> <Header> <Application>CERBERUS</Application> <Channel>Local</Channel> <UserDisplayLanguage>fr</UserDisplayLanguage> <UserDisplayCountry>FR</UserDisplayCountry> <Environment>Production</Environment> <Timestamp>2014-04-08T14:30:00.000+01:00</Timestamp> </Header> <Request> <SQLRequest><![CDATA[ SELECT DAC.NUM_SPTVTE , DAC.NUM_AN_SPTVTE , DAC.NUM_ID_PDT , DAC.NUM_DCLI1 , DAC.NUM_DCLI2 , DAC.NUM_ARTPRES , DAC.COD_SUP_DCLI2 , DAC.COD_INF_DCLI2 FROM E1DAC2_ARTVTECLI AS DAC WHERE DAC.COD_DISPART = 02 AND DAC.COD_ETA_ARTVTE = 1 WITH UR FETCH FIRST 5 ROWS ONLY ;]]> </SQLRequest> </Request> </ns:ExecuteSQLRequestRequest_1.0>";
        String envelope = request.getParameter("envelope").replace("2014-04-08T14:30:00.000 01:00","2014-04-08T14:30:00.000+01:00");
//        String servicePath = "http://prod.services.siege.red/RedouteFrance/Technical/CERBERUS/Technical/2.0?wsdl";
        String servicePath = request.getParameter("servicePath");
//        String method = "ExecuteSQLRequest_1.0";
        String method = request.getParameter("method");
        
        
        MyLogger.log(CallSOAP.class.getName(), Level.DEBUG, envelope + "|||" + envelope.length());
        
        String result = soapCall.calculatePropertyFromSOAPResponse(envelope, servicePath, method);
        MyLogger.log(CallSOAP.class.getName(), Level.DEBUG, result.toString());
        %>
        <%=result%>
     