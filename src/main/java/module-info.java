module com.rt.batchfile_app {
    requires javafx.controls;
    requires javafx.fxml;
    requires org.apache.poi.ooxml;
    requires java.desktop;
    requires java.xml;
    requires jdk.unsupported;

    opens com.rt.batchfile_app to javafx.fxml;
    exports com.rt.batchfile_app;
}
