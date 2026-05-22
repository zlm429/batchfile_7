module com.rt.batchfile_app {
    requires javafx.controls;
    requires javafx.fxml;
    requires org.apache.poi.ooxml;
    requires java.desktop;

    opens com.rt.batchfile_app to javafx.fxml;
    exports com.rt.batchfile_app;
}
