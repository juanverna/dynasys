 
 /*------------------------------------------------------------------------
    File        : DesignerForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Sun Mar 08 21:55:02 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Progress.Util.EnumHelper.
USING mfvsys.Common.BasicKeyNameElement.
USING System.Windows.Forms.DragDropEffects.
USING System.Windows.Forms.* FROM ASSEMBLY.

CLASS mfvsys.Reporte.ui.DesignerForm INHERITS FORM FINAL: 
    DEFINE PRIVATE VARIABLE barOpciones AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBar NO-UNDO.
    DEFINE PRIVATE VARIABLE bsGrid AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsReporte AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE btGrabar AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btAbrir AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btNuevo AS System.Windows.Forms.Button NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE coTablaWhere AS System.Windows.Forms.ComboBox NO-UNDO.
    DEFINE PRIVATE VARIABLE folderOpciones AS System.Windows.Forms.TabControl NO-UNDO.
    DEFINE PRIVATE VARIABLE grCamposSelec AS Infragistics.Win.UltraWinGrid.UltraGridColumnChooser NO-UNDO.
    DEFINE PRIVATE VARIABLE grReporte AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE grTablasWhere AS System.Windows.Forms.GroupBox NO-UNDO.
    DEFINE PRIVATE VARIABLE lbNombre AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbCreadoFecha AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbCreado AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbComentarios AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbCodigo AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lsTablas AS System.Windows.Forms.ListView NO-UNDO.
    DEFINE PRIVATE VARIABLE pnGrid AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnFooter AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnPrincipal AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE popupTablasWhere AS Infragistics.Win.Misc.UltraPopupControlContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE tabJoin AS System.Windows.Forms.TabPage NO-UNDO.
    DEFINE PRIVATE VARIABLE tabDetalles AS System.Windows.Forms.TabPage NO-UNDO.
    DEFINE PRIVATE VARIABLE tabCondiciones AS System.Windows.Forms.TabPage NO-UNDO. 
    DEFINE PRIVATE VARIABLE tabCampos AS System.Windows.Forms.TabPage NO-UNDO.
    DEFINE PRIVATE VARIABLE tabCabPie AS System.Windows.Forms.TabPage NO-UNDO.
    DEFINE PRIVATE VARIABLE txNombre AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txFechaCreado AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txCreadopor AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txComentario AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txCodigo AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txReporte AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE pnTop AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE lbReporte AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraExplorerBarContainerControl1 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarContainerControl NO-UNDO.

    DEFINE PRIVATE VARIABLE oldBand AS CHARACTER NO-UNDO.

    {inc/dsReporte.i}
    {inc/dsReporteSchema.i}

    DEFINE PUBLIC PROPERTY ServerHandle AS HANDLE NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY Usuario AS CHARACTER NO-UNDO GET. SET.

    DEFINE PRIVATE PROPERTY Modo AS CHARACTER NO-UNDO GET.
    SET(INPUT nuevo AS CHARACTER):
        ASSIGN Modo = nuevo.
        IF Modo = "":U THEN
            ASSIGN btAbrir:ENABLED  = TRUE
                   btNuevo:ENABLED  = TRUE
                   btGrabar:ENABLED = FALSE.
        ELSE IF Modo = "Nuevo":U OR Modo = "Modif":U THEN
            ASSIGN btAbrir:ENABLED  = FALSE
                   btNuevo:ENABLED  = FALSE
                   btGrabar:ENABLED = TRUE.
    END SET.

    DEFINE PUBLIC PROPERTY ReporteActual AS INT64 NO-UNDO GET.
    PRIVATE SET(INPUT nuevo AS INT64):
        ASSIGN ReporteActual = nuevo.
        IF nuevo = 0 THEN
            ASSIGN barOpciones:ENABLED = FALSE
                   pnFooter:ENABLED    = FALSE
                   pnGrid:ENABLED      = FALSE
                   Modo                = "".
        ELSE
            ASSIGN barOpciones:ENABLED = TRUE
                   pnFooter:ENABLED    = TRUE
                   pnGrid:ENABLED      = TRUE.
    END SET.

    DEFINE VARIABLE hDataSet   AS HANDLE    NO-UNDO.

    DEFINE TEMP-TABLE ttBuffers NO-UNDO
        FIELD Orden       AS INT64
        FIELD Nombre      AS CHARACTER
        FIELD ttBufHandle AS HANDLE
        FIELD ttHandle    AS HANDLE
        INDEX Orden orden
        INDEX ttBuffer ttBufHandle.

	CONSTRUCTOR PUBLIC DesignerForm():
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END CONSTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PRIVATE FINAL VOID AgregarBuffer(INPUT BufferName AS CHARACTER, INPUT pcTabla AS CHARACTER):
	    DEFINE VARIABLE hTT    AS HANDLE NO-UNDO.
	    DEFINE VARIABLE iOrden AS INT64  NO-UNDO.

        ASSIGN bsGrid:HANDLE = ?.

        FIND LAST ttBuffers USE-INDEX Orden NO-LOCK NO-ERROR.
        IF AVAILABLE(ttBuffers) THEN
            ASSIGN iOrden = ttBuffers.Orden + 1.
        ELSE
            ASSIGN iOrden = 1.

        CREATE TEMP-TABLE hTT.

        FOR EACH eReporteSchCampo WHERE eReporteSchCampo.Tabla = BufferName NO-LOCK:
            hTT:ADD-NEW-FIELD(eReporteSchCampo.Campo, eReporteSchCampo.Tipo).
        END.

        hTT:TEMP-TABLE-PREPARE (BufferName).
        CREATE ttBuffers.
        ASSIGN ttBuffers.Orden       = iOrden
               ttBuffers.Nombre      = BufferName
               ttBuffers.ttBufHandle = hTT:DEFAULT-BUFFER-HANDLE
               ttBuffers.ttHandle    = hTT:HANDLE.

        hTT:DEFAULT-BUFFER-HANDLE:BUFFER-CREATE().
        hDataSet:ADD-BUFFER (hTT:DEFAULT-BUFFER-HANDLE).

        bsGrid:HANDLE = hDataset.
        coTablaWhere:Items:Add(BufferName).
        
        CREATE eReporteBuffer.
        ASSIGN eReporteBuffer.IDReporte    = eReporte.IDReporte
               eReporteBuffer.NombreBuffer = BufferName
               eReporteBuffer.Tabla        = pcTabla
               eReporteBuffer.Orden        = iOrden. 
	END METHOD. /*AgregarBuffer*/

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID barOpciones_ItemClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinExplorerBar.ItemEventArgs ):
		DEFINE VARIABLE cItemKey       AS CHARACTER                        NO-UNDO.

        ASSIGN cItemKey = e:ITEM:key.

        CASE cItemKey:
            WHEN "SeleccionCampos":U THEN DO:
                grReporte:ShowColumnChooser().
            END.
            WHEN "condiciones":U THEN DO:
                IF coTablaWhere:Items:Count = 0 THEN
                    RETURN.
                ELSE IF coTablaWhere:Items:Count = 1 THEN DO:
                    FIND FIRST ttBuffers NO-LOCK NO-ERROR.
                    ProcesarCondiciones(ttBuffers.Nombre).
                END.
                ELSE
                    popupTablasWhere:Show().
            END. /*WHEN "condiciones":U THEN DO:*/
            WHEN "detalles":U THEN
                MuestraDetalles().
            /*WHEN "join":U THEN DO:
                IF hdataset:NUM-BUFFERS > 1 THEN
                    hDataset:ADD-RELATION(hdataset:GET-BUFFER-HANDLE(1),htt:DEFAULT-BUFFER-HANDLE,"idzona,idzona",false,true).
            END.*/
        END.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btAbrir_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		ASSIGN Modo = "Modif":U.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btGrabar_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    GrabarReporte().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btNuevo_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        IniciarReporte().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID coTablaWhere_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    IF coTablaWhere:SelectedIndex NE -1 THEN DO:
	        popupTablasWhere:Close().
		    ProcesarCondiciones(coTablaWhere:SelectedItem:ToString()).
		END.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC LOGICAL GrabarReporte():
	    
	    /*Como obtener columnas en el group by
	            MESSAGE ultraGrid1:DisplayLayout:Bands[0]:SortedColumns:Item[0]:Header:caption skip
        ultraGrid1:DisplayLayout:Bands[0]:SortedColumns:Item[0]:key skip
        ultraGrid1:DisplayLayout:Bands[1]:SortedColumns:Item[0]:Header:caption skip
        ultraGrid1:DisplayLayout:Bands[1]:SortedColumns:Item[0]:key skip
        VIEW-AS ALERT-BOX.*/

        /*Como obtener los campos totales y subtotales:
                ultraGrid1:DisplayLayout:Bands[0]:Summaries:Item[0]:SourceColumn:key skip
ultraGrid1:DisplayLayout:Bands[0]:Summaries:count*/
	    ASSIGN Modo = "":U.
        RETURN TRUE.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID grReporte_AfterRowActivate( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    DEFINE VARIABLE cBand AS CHARACTER NO-UNDO.
		ASSIGN cBand = grReporte:ActiveRow:Band:Key.

        IF cBand = oldBand THEN
            RETURN.

        ASSIGN oldBand = cBand.
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LOGICAL IniciarReporte():
        ASSIGN Modo = "Nuevo":U.
        MuestraDetalles().
        RETURN TRUE.
    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID grReporte_DragDrop(INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.DragEventArgs):
	    DEFINE VARIABLE cBand AS CHARACTER NO-UNDO.
        grReporte:BeginUpdate().
        ASSIGN grCamposSelec:SourceGrid = ?
               cBand = CAST(lsTablas:SelectedItems[0], System.Windows.Forms.ListViewItem):TEXT.
        FIND FIRST ttBuffers WHERE ttBuffers.Nombre = cBand NO-LOCK NO-ERROR.
        IF AVAILABLE(ttBuffers) THEN
            ASSIGN cBand = cBand + "n".
        AgregarBuffer(cBand, CAST(lsTablas:SelectedItems[0], System.Windows.Forms.ListViewItem):TEXT).
        grCamposSelec:SourceGrid = grReporte.
        grReporte:EndUpdate(TRUE).
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID grReporte_DragEnter(INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.DragEventArgs):
		e:Effect = DragDropEffects:Copy.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID lsTablas_DragEnter(INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.DragEventArgs):
		e:Effect = DragDropEffects:Copy.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PRIVATE FINAL VOID MuestraDetalles():
        DEFINE VARIABLE enDialogResult AS DialogResult                     NO-UNDO.
        DEFINE VARIABLE dialog         AS mfvsys.Reporte.ui.DetallesDialog NO-UNDO.

        IF Modo = "Nuevo":U AND NOT CAN-FIND(FIRST eReporte) THEN DO:
            CREATE eReporte.
            ASSIGN eReporte.CreadoPor   = THIS-OBJECT:Usuario
                   eReporte.CreadoFecha = NOW.
        END.
        ELSE
            FIND FIRST eReporte NO-LOCK NO-ERROR.

        ASSIGN dialog             = NEW mfvsys.Reporte.ui.DetallesDialog()
               dialog:Codigo      = STRING(eReporte.IDReporte)
               dialog:Nombre      = eReporte.Descripcion
               dialog:Comentarios = eReporte.Comentario
               dialog:Usuario     = eReporte.CreadoPor
               dialog:Fecha       = eReporte.CreadoFecha.

        WAIT-FOR dialog:ShowDialog() SET enDialogResult.
        IF EnumHelper:AreEqual (INPUT enDialogResult, INPUT DialogResult:OK) AND
           dialog:Modificado THEN DO:
               FIND CURRENT eReporte.
               ASSIGN eReporte.IDReporte   = RANDOM(1,1000000) * -1
                      eReporte.Descripcion = dialog:Nombre
                      eReporte.Comentario  = dialog:Comentarios
                      txReporte:TEXT       = eReporte.Descripcion.
               ReporteActual = eReporte.IDReporte.
        END.

        dialog:Dispose().
        dialog = ?.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID DesignerForm_Shown(INPUT sender AS System.Object, INPUT e AS System.EventArgs):
		barOpciones:BeginUpdate().
		lsTablas:BeginUpdate().

        CREATE DATASET hDataSet.
        RUN api/getreporteschema.p ON SERVER ServerHandle (OUTPUT DATASET dsReporteSchema, OUTPUT TABLE eReporteParamPredef).
        FOR EACH eReporteSchTabla NO-LOCK:
            lsTablas:Items:Add(eReporteSchTabla.Tabla).
        END.
		lsTablas:EndUpdate().
		barOpciones:EndUpdate(TRUE).
		ASSIGN Modo          = "":U
		       ReporteActual = 0.
	END METHOD.

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("mfvsys.Reporte.ui.DesignerForm").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarGroup4 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup NO-UNDO.
        ultraExplorerBarGroup4 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem2 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem2 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem6 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem6 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem1 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem1 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarGroup3 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup NO-UNDO.
        ultraExplorerBarGroup3 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance3 AS Infragistics.Win.Appearance NO-UNDO.
        appearance3 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance4 AS Infragistics.Win.Appearance NO-UNDO.
        appearance4 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance5 AS Infragistics.Win.Appearance NO-UNDO.
        appearance5 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance6 AS Infragistics.Win.Appearance NO-UNDO.
        appearance6 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance7 AS Infragistics.Win.Appearance NO-UNDO.
        appearance7 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance8 AS Infragistics.Win.Appearance NO-UNDO.
        appearance8 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance9 AS Infragistics.Win.Appearance NO-UNDO.
        appearance9 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance10 AS Infragistics.Win.Appearance NO-UNDO.
        appearance10 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance11 AS Infragistics.Win.Appearance NO-UNDO.
        appearance11 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance12 AS Infragistics.Win.Appearance NO-UNDO.
        appearance12 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("eReporte").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc2 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc2 = NEW Progress.Data.TableDesc("eReporteBuffer").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc3 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc3 = NEW Progress.Data.TableDesc("eReporteCampo").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc4 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc4 = NEW Progress.Data.TableDesc("eReporteBuffCond").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc5 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc5 = NEW Progress.Data.TableDesc("eReporteParametro").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc6 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc6 = NEW Progress.Data.TableDesc("eReporteParamPredef").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc7 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc7 = NEW Progress.Data.TableDesc("eReporteUsuario").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        THIS-OBJECT:ultraExplorerBarContainerControl1 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarContainerControl().
        THIS-OBJECT:lsTablas = NEW System.Windows.Forms.ListView().
        THIS-OBJECT:pnTop = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:btAbrir = NEW System.Windows.Forms.Button().
        THIS-OBJECT:btGrabar = NEW System.Windows.Forms.Button().
        THIS-OBJECT:btNuevo = NEW System.Windows.Forms.Button().
        THIS-OBJECT:txReporte = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbReporte = NEW System.Windows.Forms.Label().
        THIS-OBJECT:barOpciones = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBar().
        THIS-OBJECT:pnPrincipal = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:pnGrid = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:grTablasWhere = NEW System.Windows.Forms.GroupBox().
        THIS-OBJECT:coTablaWhere = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:grReporte = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:bsGrid = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:pnFooter = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:folderOpciones = NEW System.Windows.Forms.TabControl().
        THIS-OBJECT:tabDetalles = NEW System.Windows.Forms.TabPage().
        THIS-OBJECT:lbCodigo = NEW System.Windows.Forms.Label().
        THIS-OBJECT:txComentario = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:txFechaCreado = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbComentarios = NEW System.Windows.Forms.Label().
        THIS-OBJECT:lbNombre = NEW System.Windows.Forms.Label().
        THIS-OBJECT:txCodigo = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbCreadoFecha = NEW System.Windows.Forms.Label().
        THIS-OBJECT:lbCreado = NEW System.Windows.Forms.Label().
        THIS-OBJECT:txCreadopor = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:txNombre = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:tabCondiciones = NEW System.Windows.Forms.TabPage().
        THIS-OBJECT:tabCabPie = NEW System.Windows.Forms.TabPage().
        THIS-OBJECT:tabCampos = NEW System.Windows.Forms.TabPage().
        THIS-OBJECT:tabJoin = NEW System.Windows.Forms.TabPage().
        THIS-OBJECT:popupTablasWhere = NEW Infragistics.Win.Misc.UltraPopupControlContainer(THIS-OBJECT:components).
        THIS-OBJECT:bsReporte = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:grCamposSelec = NEW Infragistics.Win.UltraWinGrid.UltraGridColumnChooser().
        THIS-OBJECT:ultraExplorerBarContainerControl1:SuspendLayout().
        THIS-OBJECT:pnTop:SuspendLayout().
        CAST(THIS-OBJECT:barOpciones, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:barOpciones:SuspendLayout().
        THIS-OBJECT:pnPrincipal:SuspendLayout().
        THIS-OBJECT:pnGrid:SuspendLayout().
        THIS-OBJECT:grTablasWhere:SuspendLayout().
        CAST(THIS-OBJECT:grReporte, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsGrid, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:pnFooter:SuspendLayout().
        THIS-OBJECT:folderOpciones:SuspendLayout().
        THIS-OBJECT:tabDetalles:SuspendLayout().
        THIS-OBJECT:tabCampos:SuspendLayout().
        CAST(THIS-OBJECT:bsReporte, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:grCamposSelec, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraExplorerBarContainerControl1 */
        /*  */
        THIS-OBJECT:ultraExplorerBarContainerControl1:Controls:Add(THIS-OBJECT:lsTablas).
        THIS-OBJECT:ultraExplorerBarContainerControl1:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraExplorerBarContainerControl1:Name = "ultraExplorerBarContainerControl1".
        THIS-OBJECT:ultraExplorerBarContainerControl1:Size = NEW System.Drawing.Size(173, 434).
        THIS-OBJECT:ultraExplorerBarContainerControl1:TabIndex = 0.
        THIS-OBJECT:ultraExplorerBarContainerControl1:Visible = FALSE.
        /*  */
        /* lsTablas */
        /*  */
        THIS-OBJECT:lsTablas:AutoArrange = FALSE.
        THIS-OBJECT:lsTablas:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:lsTablas:FullRowSelect = TRUE.
        THIS-OBJECT:lsTablas:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:lsTablas:MultiSelect = FALSE.
        THIS-OBJECT:lsTablas:Name = "lsTablas".
        THIS-OBJECT:lsTablas:ShowGroups = FALSE.
        THIS-OBJECT:lsTablas:Size = NEW System.Drawing.Size(173, 434).
        THIS-OBJECT:lsTablas:TabIndex = 1.
        THIS-OBJECT:lsTablas:UseCompatibleStateImageBehavior = FALSE.
        THIS-OBJECT:lsTablas:View = System.Windows.Forms.View:List.
        THIS-OBJECT:lsTablas:ItemDrag:Subscribe(THIS-OBJECT:lsTablas_ItemDrag).
        THIS-OBJECT:lsTablas:DragEnter:Subscribe(THIS-OBJECT:lsTablas_DragEnter).
        /*  */
        /* pnTop */
        /*  */
        THIS-OBJECT:pnTop:AllowDrop = TRUE.
        THIS-OBJECT:pnTop:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnTop:Controls:Add(THIS-OBJECT:btAbrir).
        THIS-OBJECT:pnTop:Controls:Add(THIS-OBJECT:btGrabar).
        THIS-OBJECT:pnTop:Controls:Add(THIS-OBJECT:btNuevo).
        THIS-OBJECT:pnTop:Controls:Add(THIS-OBJECT:txReporte).
        THIS-OBJECT:pnTop:Controls:Add(THIS-OBJECT:lbReporte).
        THIS-OBJECT:pnTop:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:pnTop:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:pnTop:Name = "pnTop".
        THIS-OBJECT:pnTop:Size = NEW System.Drawing.Size(799, 38).
        THIS-OBJECT:pnTop:TabIndex = 0.
        /*  */
        /* btAbrir */
        /*  */
        THIS-OBJECT:btAbrir:Image = CAST(resources:GetObject("btAbrir.Image"), System.Drawing.Image).
        THIS-OBJECT:btAbrir:ImageAlign = System.Drawing.ContentAlignment:TopCenter.
        THIS-OBJECT:btAbrir:Location = NEW System.Drawing.Point(377, 8).
        THIS-OBJECT:btAbrir:Name = "btAbrir".
        THIS-OBJECT:btAbrir:Size = NEW System.Drawing.Size(25, 23).
        THIS-OBJECT:btAbrir:TabIndex = 4.
        THIS-OBJECT:btAbrir:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btAbrir:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btAbrir:Click:Subscribe(THIS-OBJECT:btAbrir_Click).
        /*  */
        /* btGrabar */
        /*  */
        THIS-OBJECT:btGrabar:Image = CAST(resources:GetObject("btGrabar.Image"), System.Drawing.Image).
        THIS-OBJECT:btGrabar:ImageAlign = System.Drawing.ContentAlignment:TopCenter.
        THIS-OBJECT:btGrabar:Location = NEW System.Drawing.Point(401, 8).
        THIS-OBJECT:btGrabar:Name = "btGrabar".
        THIS-OBJECT:btGrabar:Size = NEW System.Drawing.Size(25, 23).
        THIS-OBJECT:btGrabar:TabIndex = 3.
        THIS-OBJECT:btGrabar:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btGrabar:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btGrabar:Click:Subscribe(THIS-OBJECT:btGrabar_Click).
        /*  */
        /* btNuevo */
        /*  */
        THIS-OBJECT:btNuevo:Image = CAST(resources:GetObject("btNuevo.Image"), System.Drawing.Image).
        THIS-OBJECT:btNuevo:ImageAlign = System.Drawing.ContentAlignment:TopCenter.
        THIS-OBJECT:btNuevo:Location = NEW System.Drawing.Point(353, 8).
        THIS-OBJECT:btNuevo:Name = "btNuevo".
        THIS-OBJECT:btNuevo:Size = NEW System.Drawing.Size(25, 23).
        THIS-OBJECT:btNuevo:TabIndex = 2.
        THIS-OBJECT:btNuevo:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btNuevo:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btNuevo:Click:Subscribe(THIS-OBJECT:btNuevo_Click).
        /*  */
        /* txReporte */
        /*  */
        THIS-OBJECT:txReporte:Location = NEW System.Drawing.Point(59, 9).
        THIS-OBJECT:txReporte:Name = "txReporte".
        THIS-OBJECT:txReporte:ReadOnly = TRUE.
        THIS-OBJECT:txReporte:Size = NEW System.Drawing.Size(290, 20).
        THIS-OBJECT:txReporte:TabIndex = 1.
        /*  */
        /* lbReporte */
        /*  */
        THIS-OBJECT:lbReporte:Location = NEW System.Drawing.Point(3, 7).
        THIS-OBJECT:lbReporte:Name = "lbReporte".
        THIS-OBJECT:lbReporte:Size = NEW System.Drawing.Size(50, 23).
        THIS-OBJECT:lbReporte:TabIndex = 0.
        THIS-OBJECT:lbReporte:Text = "Reporte:".
        THIS-OBJECT:lbReporte:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbReporte:UseCompatibleTextRendering = TRUE.
        /*  */
        /* barOpciones */
        /*  */
        THIS-OBJECT:barOpciones:Controls:Add(THIS-OBJECT:ultraExplorerBarContainerControl1).
        THIS-OBJECT:barOpciones:Dock = System.Windows.Forms.DockStyle:Left.
        ultraExplorerBarItem2:Key = "detalles".
        ultraExplorerBarItem2:Text = "Detalles".
        ultraExplorerBarItem6:Key = "SeleccionCampos".
        ultraExplorerBarItem6:Text = "Seleccionar Campos".
        ultraExplorerBarItem1:Key = "condiciones".
        ultraExplorerBarItem1:Settings:AllowEdit = Infragistics.Win.DefaultableBoolean:False.
        ultraExplorerBarItem1:Settings:Style = Infragistics.Win.UltraWinExplorerBar.ItemStyle:Button.
        ultraExplorerBarItem1:Text = "Condiciones (WHERE)".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem EXTENT 3 NO-UNDO.
        arrayvar0[1] = ultraExplorerBarItem2.
        arrayvar0[2] = ultraExplorerBarItem6.
        arrayvar0[3] = ultraExplorerBarItem1.
        ultraExplorerBarGroup4:Items:AddRange(arrayvar0).
        ultraExplorerBarGroup4:Text = "Opciones".
        ultraExplorerBarGroup3:Container = THIS-OBJECT:ultraExplorerBarContainerControl1.
        ultraExplorerBarGroup3:Settings:Style = Infragistics.Win.UltraWinExplorerBar.GroupStyle:ControlContainer.
        ultraExplorerBarGroup3:Text = "Tablas".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup EXTENT 2 NO-UNDO.
        arrayvar1[1] = ultraExplorerBarGroup4.
        arrayvar1[2] = ultraExplorerBarGroup3.
        THIS-OBJECT:barOpciones:Groups:AddRange(arrayvar1).
        THIS-OBJECT:barOpciones:Location = NEW System.Drawing.Point(0, 38).
        THIS-OBJECT:barOpciones:Name = "barOpciones".
        DEFINE VARIABLE nestedvar0 AS Infragistics.Win.UltraWinExplorerBar.NavigationPaneExpansionMode NO-UNDO.
        nestedvar0 = Infragistics.Win.UltraWinExplorerBar.NavigationPaneExpansionMode:OnButtonClick.
        THIS-OBJECT:barOpciones:NavigationPaneExpansionMode = CAST(Progress.Util.EnumHelper:Or(nestedvar0, Infragistics.Win.UltraWinExplorerBar.NavigationPaneExpansionMode:OnSizeChanged), Infragistics.Win.UltraWinExplorerBar.NavigationPaneExpansionMode).
        THIS-OBJECT:barOpciones:Size = NEW System.Drawing.Size(175, 551).
        THIS-OBJECT:barOpciones:Style = Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarStyle:OutlookNavigationPane.
        THIS-OBJECT:barOpciones:TabIndex = 3.
        THIS-OBJECT:barOpciones:ItemClick:Subscribe(THIS-OBJECT:barOpciones_ItemClick).
        /*  */
        /* pnPrincipal */
        /*  */
        THIS-OBJECT:pnPrincipal:Controls:Add(THIS-OBJECT:pnGrid).
        THIS-OBJECT:pnPrincipal:Controls:Add(THIS-OBJECT:pnFooter).
        THIS-OBJECT:pnPrincipal:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:pnPrincipal:Location = NEW System.Drawing.Point(175, 38).
        THIS-OBJECT:pnPrincipal:Name = "pnPrincipal".
        THIS-OBJECT:pnPrincipal:Size = NEW System.Drawing.Size(624, 551).
        THIS-OBJECT:pnPrincipal:TabIndex = 4.
        /*  */
        /* pnGrid */
        /*  */
        THIS-OBJECT:pnGrid:Controls:Add(THIS-OBJECT:grTablasWhere).
        THIS-OBJECT:pnGrid:Controls:Add(THIS-OBJECT:grReporte).
        THIS-OBJECT:pnGrid:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:pnGrid:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:pnGrid:Name = "pnGrid".
        THIS-OBJECT:pnGrid:Size = NEW System.Drawing.Size(624, 236).
        THIS-OBJECT:pnGrid:TabIndex = 3.
        /*  */
        /* grTablasWhere */
        /*  */
        THIS-OBJECT:grTablasWhere:Controls:Add(THIS-OBJECT:coTablaWhere).
        THIS-OBJECT:grTablasWhere:Location = NEW System.Drawing.Point(221, 102).
        THIS-OBJECT:grTablasWhere:Name = "grTablasWhere".
        THIS-OBJECT:grTablasWhere:Size = NEW System.Drawing.Size(200, 47).
        THIS-OBJECT:grTablasWhere:TabIndex = 1.
        THIS-OBJECT:grTablasWhere:TabStop = FALSE.
        THIS-OBJECT:grTablasWhere:Text = "Seleccion de Tabla".
        THIS-OBJECT:grTablasWhere:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:grTablasWhere:Visible = FALSE.
        /*  */
        /* coTablaWhere */
        /*  */
        THIS-OBJECT:coTablaWhere:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList.
        THIS-OBJECT:coTablaWhere:FormattingEnabled = TRUE.
        THIS-OBJECT:coTablaWhere:Location = NEW System.Drawing.Point(7, 19).
        THIS-OBJECT:coTablaWhere:Name = "coTablaWhere".
        THIS-OBJECT:coTablaWhere:Size = NEW System.Drawing.Size(187, 21).
        THIS-OBJECT:coTablaWhere:Sorted = TRUE.
        THIS-OBJECT:coTablaWhere:TabIndex = 0.
        THIS-OBJECT:coTablaWhere:SelectedIndexChanged:Subscribe(THIS-OBJECT:coTablaWhere_SelectedIndexChanged).
        /*  */
        /* grReporte */
        /*  */
        THIS-OBJECT:grReporte:AllowDrop = TRUE.
        THIS-OBJECT:grReporte:DataSource = THIS-OBJECT:bsGrid.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:grReporte:DisplayLayout:Appearance = appearance1.
        THIS-OBJECT:grReporte:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:grReporte:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:Prompt = "Arrastre una columna para agrupar".
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:grReporte:DisplayLayout:LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle:LoadOnDemand.
        THIS-OBJECT:grReporte:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:grReporte:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:grReporte:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:grReporte:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:grReporte:DisplayLayout:Override:AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew:Yes.
        THIS-OBJECT:grReporte:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:grReporte:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:grReporte:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grReporte:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:grReporte:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:grReporte:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:grReporte:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:grReporte:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:grReporte:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:grReporte:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:grReporte:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:grReporte:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:grReporte:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:grReporte:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:grReporte:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:grReporte:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:grReporte:Name = "grReporte".
        THIS-OBJECT:grReporte:Size = NEW System.Drawing.Size(624, 236).
        THIS-OBJECT:grReporte:TabIndex = 0.
        THIS-OBJECT:grReporte:Text = "ultraGrid1".
        THIS-OBJECT:grReporte:AfterRowActivate:Subscribe(THIS-OBJECT:grReporte_AfterRowActivate).
        THIS-OBJECT:grReporte:DragDrop:Subscribe(THIS-OBJECT:grReporte_DragDrop).
        THIS-OBJECT:grReporte:DragEnter:Subscribe(THIS-OBJECT:grReporte_DragEnter).
        /*  */
        /* bsGrid */
        /*  */
        THIS-OBJECT:bsGrid:MaxDataGuess = 0.
        THIS-OBJECT:bsGrid:NoLOBs = FALSE.
        THIS-OBJECT:bsGrid:TableSchema = ?.
        /*  */
        /* pnFooter */
        /*  */
        THIS-OBJECT:pnFooter:Controls:Add(THIS-OBJECT:folderOpciones).
        THIS-OBJECT:pnFooter:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:pnFooter:Location = NEW System.Drawing.Point(0, 236).
        THIS-OBJECT:pnFooter:Name = "pnFooter".
        THIS-OBJECT:pnFooter:Size = NEW System.Drawing.Size(624, 315).
        THIS-OBJECT:pnFooter:TabIndex = 2.
        /*  */
        /* folderOpciones */
        /*  */
        THIS-OBJECT:folderOpciones:Controls:Add(THIS-OBJECT:tabDetalles).
        THIS-OBJECT:folderOpciones:Controls:Add(THIS-OBJECT:tabCondiciones).
        THIS-OBJECT:folderOpciones:Controls:Add(THIS-OBJECT:tabCabPie).
        THIS-OBJECT:folderOpciones:Controls:Add(THIS-OBJECT:tabCampos).
        THIS-OBJECT:folderOpciones:Controls:Add(THIS-OBJECT:tabJoin).
        THIS-OBJECT:folderOpciones:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:folderOpciones:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:folderOpciones:Name = "folderOpciones".
        THIS-OBJECT:folderOpciones:SelectedIndex = 0.
        THIS-OBJECT:folderOpciones:Size = NEW System.Drawing.Size(624, 315).
        THIS-OBJECT:folderOpciones:TabIndex = 0.
        /*  */
        /* tabDetalles */
        /*  */
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:lbCodigo).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:txComentario).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:txFechaCreado).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:lbComentarios).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:lbNombre).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:txCodigo).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:lbCreadoFecha).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:lbCreado).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:txCreadopor).
        THIS-OBJECT:tabDetalles:Controls:Add(THIS-OBJECT:txNombre).
        THIS-OBJECT:tabDetalles:Location = NEW System.Drawing.Point(4, 22).
        THIS-OBJECT:tabDetalles:Name = "tabDetalles".
        THIS-OBJECT:tabDetalles:Size = NEW System.Drawing.Size(616, 289).
        THIS-OBJECT:tabDetalles:TabIndex = 2.
        THIS-OBJECT:tabDetalles:Text = "Detalles".
        THIS-OBJECT:tabDetalles:ToolTipText = "Detalles del Reporte".
        THIS-OBJECT:tabDetalles:UseVisualStyleBackColor = TRUE.
        /*  */
        /* lbCodigo */
        /*  */
        THIS-OBJECT:lbCodigo:Location = NEW System.Drawing.Point(124, 51).
        THIS-OBJECT:lbCodigo:Name = "lbCodigo".
        THIS-OBJECT:lbCodigo:Size = NEW System.Drawing.Size(49, 23).
        THIS-OBJECT:lbCodigo:TabIndex = 18.
        THIS-OBJECT:lbCodigo:Text = "Codigo:".
        THIS-OBJECT:lbCodigo:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbCodigo:UseCompatibleTextRendering = TRUE.
        /*  */
        /* txComentario */
        /*  */
        THIS-OBJECT:txComentario:Location = NEW System.Drawing.Point(176, 107).
        THIS-OBJECT:txComentario:Multiline = TRUE.
        THIS-OBJECT:txComentario:Name = "txComentario".
        THIS-OBJECT:txComentario:Size = NEW System.Drawing.Size(276, 99).
        THIS-OBJECT:txComentario:TabIndex = 13.
        /*  */
        /* txFechaCreado */
        /*  */
        THIS-OBJECT:txFechaCreado:Location = NEW System.Drawing.Point(320, 212).
        THIS-OBJECT:txFechaCreado:Name = "txFechaCreado".
        THIS-OBJECT:txFechaCreado:ReadOnly = TRUE.
        THIS-OBJECT:txFechaCreado:Size = NEW System.Drawing.Size(132, 20).
        THIS-OBJECT:txFechaCreado:TabIndex = 15.
        THIS-OBJECT:txFechaCreado:TabStop = FALSE.
        /*  */
        /* lbComentarios */
        /*  */
        THIS-OBJECT:lbComentarios:Location = NEW System.Drawing.Point(101, 100).
        THIS-OBJECT:lbComentarios:Name = "lbComentarios".
        THIS-OBJECT:lbComentarios:Size = NEW System.Drawing.Size(72, 23).
        THIS-OBJECT:lbComentarios:TabIndex = 17.
        THIS-OBJECT:lbComentarios:Text = "Comentarios:".
        THIS-OBJECT:lbComentarios:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbComentarios:UseCompatibleTextRendering = TRUE.
        /*  */
        /* lbNombre */
        /*  */
        THIS-OBJECT:lbNombre:Location = NEW System.Drawing.Point(124, 75).
        THIS-OBJECT:lbNombre:Name = "lbNombre".
        THIS-OBJECT:lbNombre:Size = NEW System.Drawing.Size(49, 23).
        THIS-OBJECT:lbNombre:TabIndex = 16.
        THIS-OBJECT:lbNombre:Text = "Nombre:".
        THIS-OBJECT:lbNombre:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbNombre:UseCompatibleTextRendering = TRUE.
        /*  */
        /* txCodigo */
        /*  */
        THIS-OBJECT:txCodigo:Location = NEW System.Drawing.Point(176, 53).
        THIS-OBJECT:txCodigo:Name = "txCodigo".
        THIS-OBJECT:txCodigo:ReadOnly = TRUE.
        THIS-OBJECT:txCodigo:Size = NEW System.Drawing.Size(69, 20).
        THIS-OBJECT:txCodigo:TabIndex = 19.
        THIS-OBJECT:txCodigo:TabStop = FALSE.
        /*  */
        /* lbCreadoFecha */
        /*  */
        THIS-OBJECT:lbCreadoFecha:Location = NEW System.Drawing.Point(271, 213).
        THIS-OBJECT:lbCreadoFecha:Name = "lbCreadoFecha".
        THIS-OBJECT:lbCreadoFecha:Size = NEW System.Drawing.Size(43, 19).
        THIS-OBJECT:lbCreadoFecha:TabIndex = 14.
        THIS-OBJECT:lbCreadoFecha:Text = "Fecha:".
        THIS-OBJECT:lbCreadoFecha:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbCreadoFecha:UseCompatibleTextRendering = TRUE.
        /*  */
        /* lbCreado */
        /*  */
        THIS-OBJECT:lbCreado:Location = NEW System.Drawing.Point(109, 214).
        THIS-OBJECT:lbCreado:Name = "lbCreado".
        THIS-OBJECT:lbCreado:Size = NEW System.Drawing.Size(64, 19).
        THIS-OBJECT:lbCreado:TabIndex = 10.
        THIS-OBJECT:lbCreado:Text = "Creado por:".
        THIS-OBJECT:lbCreado:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbCreado:UseCompatibleTextRendering = TRUE.
        /*  */
        /* txCreadopor */
        /*  */
        THIS-OBJECT:txCreadopor:Location = NEW System.Drawing.Point(177, 213).
        THIS-OBJECT:txCreadopor:Name = "txCreadopor".
        THIS-OBJECT:txCreadopor:ReadOnly = TRUE.
        THIS-OBJECT:txCreadopor:Size = NEW System.Drawing.Size(100, 20).
        THIS-OBJECT:txCreadopor:TabIndex = 11.
        THIS-OBJECT:txCreadopor:TabStop = FALSE.
        /*  */
        /* txNombre */
        /*  */
        THIS-OBJECT:txNombre:Location = NEW System.Drawing.Point(176, 77).
        THIS-OBJECT:txNombre:Name = "txNombre".
        THIS-OBJECT:txNombre:Size = NEW System.Drawing.Size(262, 20).
        THIS-OBJECT:txNombre:TabIndex = 12.
        /*  */
        /* tabCondiciones */
        /*  */
        THIS-OBJECT:tabCondiciones:Location = NEW System.Drawing.Point(4, 22).
        THIS-OBJECT:tabCondiciones:Name = "tabCondiciones".
        THIS-OBJECT:tabCondiciones:Padding = NEW System.Windows.Forms.Padding(3).
        THIS-OBJECT:tabCondiciones:Size = NEW System.Drawing.Size(616, 289).
        THIS-OBJECT:tabCondiciones:TabIndex = 0.
        THIS-OBJECT:tabCondiciones:Text = "Condiciones (Where)".
        THIS-OBJECT:tabCondiciones:ToolTipText = "Condiciones de Tablas (Where)".
        THIS-OBJECT:tabCondiciones:UseVisualStyleBackColor = TRUE.
        /*  */
        /* tabCabPie */
        /*  */
        THIS-OBJECT:tabCabPie:Location = NEW System.Drawing.Point(4, 22).
        THIS-OBJECT:tabCabPie:Name = "tabCabPie".
        THIS-OBJECT:tabCabPie:Padding = NEW System.Windows.Forms.Padding(3).
        THIS-OBJECT:tabCabPie:Size = NEW System.Drawing.Size(616, 289).
        THIS-OBJECT:tabCabPie:TabIndex = 1.
        THIS-OBJECT:tabCabPie:Text = "Cabecera/Pie".
        THIS-OBJECT:tabCabPie:ToolTipText = "Cabecera/Pie del Reporte".
        THIS-OBJECT:tabCabPie:UseVisualStyleBackColor = TRUE.
        /*  */
        /* tabCampos */
        /*  */
        THIS-OBJECT:tabCampos:Controls:Add(THIS-OBJECT:grCamposSelec).
        THIS-OBJECT:tabCampos:Location = NEW System.Drawing.Point(4, 22).
        THIS-OBJECT:tabCampos:Name = "tabCampos".
        THIS-OBJECT:tabCampos:Size = NEW System.Drawing.Size(616, 289).
        THIS-OBJECT:tabCampos:TabIndex = 3.
        THIS-OBJECT:tabCampos:Text = "Campos".
        THIS-OBJECT:tabCampos:ToolTipText = "Seleccion de Campos para el Reporte".
        THIS-OBJECT:tabCampos:UseVisualStyleBackColor = TRUE.
        /*  */
        /* tabJoin */
        /*  */
        THIS-OBJECT:tabJoin:Location = NEW System.Drawing.Point(4, 22).
        THIS-OBJECT:tabJoin:Name = "tabJoin".
        THIS-OBJECT:tabJoin:Size = NEW System.Drawing.Size(616, 289).
        THIS-OBJECT:tabJoin:TabIndex = 4.
        THIS-OBJECT:tabJoin:Text = "Joins (Uniones)".
        THIS-OBJECT:tabJoin:ToolTipText = "Uniones entre Tablas (Joins)".
        THIS-OBJECT:tabJoin:UseVisualStyleBackColor = TRUE.
        /*  */
        /* popupTablasWhere */
        /*  */
        THIS-OBJECT:popupTablasWhere:PopupControl = THIS-OBJECT:grTablasWhere.
        /*  */
        /* bsReporte */
        /*  */
        THIS-OBJECT:bsReporte:MaxDataGuess = 0.
        THIS-OBJECT:bsReporte:NoLOBs = FALSE.
        THIS-OBJECT:bsReporte:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar2 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc3:ChildTables = arrayvar2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Progress.Data.ColumnPropDesc EXTENT 9 NO-UNDO.
        arrayvar3[1] = NEW Progress.Data.ColumnPropDesc("IDReporte", "Reporte", Progress.Data.DataType:INT64).
        arrayvar3[2] = NEW Progress.Data.ColumnPropDesc("BufferNombre", "Nombre", Progress.Data.DataType:CHARACTER).
        arrayvar3[3] = NEW Progress.Data.ColumnPropDesc("Tipo", "Tipo De Campo", Progress.Data.DataType:CHARACTER).
        arrayvar3[4] = NEW Progress.Data.ColumnPropDesc("TablaOrigen", "Tabla Origen", Progress.Data.DataType:CHARACTER).
        arrayvar3[5] = NEW Progress.Data.ColumnPropDesc("CampoOrigen", "Campo Origen", Progress.Data.DataType:CHARACTER).
        arrayvar3[6] = NEW Progress.Data.ColumnPropDesc("Relacion", "Llaves", Progress.Data.DataType:CHARACTER).
        arrayvar3[7] = NEW Progress.Data.ColumnPropDesc("Campo", "Nombre", Progress.Data.DataType:CHARACTER).
        arrayvar3[8] = NEW Progress.Data.ColumnPropDesc("AcumPor", "Acumular Por", Progress.Data.DataType:CHARACTER).
        arrayvar3[9] = NEW Progress.Data.ColumnPropDesc("AcumBreakBy", "Break By", Progress.Data.DataType:CHARACTER).
        tableDesc3:Columns = arrayvar3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar4 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc6:ChildTables = arrayvar4.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Progress.Data.ColumnPropDesc EXTENT 5 NO-UNDO.
        arrayvar5[1] = NEW Progress.Data.ColumnPropDesc("Nombre", "Nombre", Progress.Data.DataType:CHARACTER).
        arrayvar5[2] = NEW Progress.Data.ColumnPropDesc("IDParamPred", "ID", Progress.Data.DataType:INT64).
        arrayvar5[3] = NEW Progress.Data.ColumnPropDesc("Valor", "Valor", Progress.Data.DataType:CHARACTER).
        arrayvar5[4] = NEW Progress.Data.ColumnPropDesc("Descripcion", "Descripcion", Progress.Data.DataType:CHARACTER).
        arrayvar5[5] = NEW Progress.Data.ColumnPropDesc("Tipo", "Tipo De Campo", Progress.Data.DataType:CHARACTER).
        tableDesc6:Columns = arrayvar5.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS Progress.Data.TableDesc EXTENT 1 NO-UNDO.
        arrayvar6[1] = tableDesc6.
        tableDesc5:ChildTables = arrayvar6.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS Progress.Data.ColumnPropDesc EXTENT 16 NO-UNDO.
        arrayvar7[1] = NEW Progress.Data.ColumnPropDesc("IDReporte", "Reporte", Progress.Data.DataType:INT64).
        arrayvar7[2] = NEW Progress.Data.ColumnPropDesc("NombreBuffer", "Buffer", Progress.Data.DataType:CHARACTER).
        arrayvar7[3] = NEW Progress.Data.ColumnPropDesc("IDCondicion", "IDCondicion", Progress.Data.DataType:INT64).
        arrayvar7[4] = NEW Progress.Data.ColumnPropDesc("NombreParametro", "Parametro", Progress.Data.DataType:CHARACTER).
        arrayvar7[5] = NEW Progress.Data.ColumnPropDesc("IDParamPred", "ID", Progress.Data.DataType:RECID).
        arrayvar7[6] = NEW Progress.Data.ColumnPropDesc("DataType", "Tipo", Progress.Data.DataType:CHARACTER).
        arrayvar7[7] = NEW Progress.Data.ColumnPropDesc("Valor", "Valor", Progress.Data.DataType:CHARACTER).
        arrayvar7[8] = NEW Progress.Data.ColumnPropDesc("Formato", "Formato", Progress.Data.DataType:CHARACTER).
        arrayvar7[9] = NEW Progress.Data.ColumnPropDesc("Buscador", "Buscador", Progress.Data.DataType:LOGICAL).
        arrayvar7[10] = NEW Progress.Data.ColumnPropDesc("BuscadorTabla", "Tabla Popup", Progress.Data.DataType:CHARACTER).
        arrayvar7[11] = NEW Progress.Data.ColumnPropDesc("BuscadorCampoID", "Campo ID", Progress.Data.DataType:CHARACTER).
        arrayvar7[12] = NEW Progress.Data.ColumnPropDesc("EtiquetaParametro", "Etiqueta", Progress.Data.DataType:CHARACTER).
        arrayvar7[13] = NEW Progress.Data.ColumnPropDesc("BuscadorCampoNombre", "Popup Display", Progress.Data.DataType:CHARACTER).
        arrayvar7[14] = NEW Progress.Data.ColumnPropDesc("BuscadorTipo", "Tipo de Buscador", Progress.Data.DataType:CHARACTER).
        arrayvar7[15] = NEW Progress.Data.ColumnPropDesc("ValoresCombo", "Valores Combo", Progress.Data.DataType:CHARACTER).
        arrayvar7[16] = NEW Progress.Data.ColumnPropDesc("ViewAs", "Ver Como", Progress.Data.DataType:CHARACTER).
        tableDesc5:Columns = arrayvar7.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS Progress.Data.TableDesc EXTENT 1 NO-UNDO.
        arrayvar8[1] = tableDesc5.
        tableDesc4:ChildTables = arrayvar8.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar9 AS Progress.Data.ColumnPropDesc EXTENT 9 NO-UNDO.
        arrayvar9[1] = NEW Progress.Data.ColumnPropDesc("IDReporte", "Reporte", Progress.Data.DataType:INT64).
        arrayvar9[2] = NEW Progress.Data.ColumnPropDesc("NombreBuffer", "Nombre", Progress.Data.DataType:CHARACTER).
        arrayvar9[3] = NEW Progress.Data.ColumnPropDesc("IDCondicion", "IDCondicion", Progress.Data.DataType:INT64).
        arrayvar9[4] = NEW Progress.Data.ColumnPropDesc("ParentesisIzq", "Parentesis a la izquierda", Progress.Data.DataType:CHARACTER).
        arrayvar9[5] = NEW Progress.Data.ColumnPropDesc("Campo", "Campo", Progress.Data.DataType:CHARACTER).
        arrayvar9[6] = NEW Progress.Data.ColumnPropDesc("Operador", "Operador", Progress.Data.DataType:CHARACTER).
        arrayvar9[7] = NEW Progress.Data.ColumnPropDesc("Valor", "Valor de la condicion", Progress.Data.DataType:CHARACTER).
        arrayvar9[8] = NEW Progress.Data.ColumnPropDesc("ParentesisDer", "Parentesis a la derecha", Progress.Data.DataType:CHARACTER).
        arrayvar9[9] = NEW Progress.Data.ColumnPropDesc("AndOr", "Condicion And/Or", Progress.Data.DataType:CHARACTER).
        tableDesc4:Columns = arrayvar9.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar10 AS Progress.Data.TableDesc EXTENT 2 NO-UNDO.
        arrayvar10[1] = tableDesc3.
        arrayvar10[2] = tableDesc4.
        tableDesc2:ChildTables = arrayvar10.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar11 AS Progress.Data.ColumnPropDesc EXTENT 6 NO-UNDO.
        arrayvar11[1] = NEW Progress.Data.ColumnPropDesc("IDReporte", "Reporte", Progress.Data.DataType:INT64).
        arrayvar11[2] = NEW Progress.Data.ColumnPropDesc("NombreBuffer", "Nombre", Progress.Data.DataType:CHARACTER).
        arrayvar11[3] = NEW Progress.Data.ColumnPropDesc("AfterFillProcedure", "Procedimiento After Fill", Progress.Data.DataType:CHARACTER).
        arrayvar11[4] = NEW Progress.Data.ColumnPropDesc("Tabla", "Tabla", Progress.Data.DataType:CHARACTER).
        arrayvar11[5] = NEW Progress.Data.ColumnPropDesc("GroupByCampos", "Group By", Progress.Data.DataType:CHARACTER).
        arrayvar11[6] = NEW Progress.Data.ColumnPropDesc("Orden", "Orden", Progress.Data.DataType:RECID).
        tableDesc2:Columns = arrayvar11.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar12 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar12 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc7:ChildTables = arrayvar12.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar13 AS Progress.Data.ColumnPropDesc EXTENT 4 NO-UNDO.
        arrayvar13[1] = NEW Progress.Data.ColumnPropDesc("usuario", "Usuario", Progress.Data.DataType:CHARACTER).
        arrayvar13[2] = NEW Progress.Data.ColumnPropDesc("IDReporte", "Reporte", Progress.Data.DataType:INT64).
        arrayvar13[3] = NEW Progress.Data.ColumnPropDesc("Mobile", "Mobile", Progress.Data.DataType:LOGICAL).
        arrayvar13[4] = NEW Progress.Data.ColumnPropDesc("UI", "UI", Progress.Data.DataType:LOGICAL).
        tableDesc7:Columns = arrayvar13.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar14 AS Progress.Data.TableDesc EXTENT 2 NO-UNDO.
        arrayvar14[1] = tableDesc2.
        arrayvar14[2] = tableDesc7.
        tableDesc1:ChildTables = arrayvar14.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar15 AS Progress.Data.ColumnPropDesc EXTENT 9 NO-UNDO.
        arrayvar15[1] = NEW Progress.Data.ColumnPropDesc("IDReporte", "Reporte", Progress.Data.DataType:INT64).
        arrayvar15[2] = NEW Progress.Data.ColumnPropDesc("Descripcion", "Descripcion", Progress.Data.DataType:CHARACTER).
        arrayvar15[3] = NEW Progress.Data.ColumnPropDesc("Comentario", "Comentario", Progress.Data.DataType:CHARACTER).
        arrayvar15[4] = NEW Progress.Data.ColumnPropDesc("Esquema", "", Progress.Data.DataType:CHARACTER).
        arrayvar15[5] = NEW Progress.Data.ColumnPropDesc("AfterFillProcedure", "Procedimiento After Fill", Progress.Data.DataType:CHARACTER).
        arrayvar15[6] = NEW Progress.Data.ColumnPropDesc("Programa", "Programa ABL", Progress.Data.DataType:CHARACTER).
        arrayvar15[7] = NEW Progress.Data.ColumnPropDesc("GridLayout", "", Progress.Data.DataType:BLOB).
        arrayvar15[8] = NEW Progress.Data.ColumnPropDesc("CreadoPor", "Creado por", Progress.Data.DataType:CHARACTER).
        arrayvar15[9] = NEW Progress.Data.ColumnPropDesc("CreadoFecha", "Fecha Creacion", Progress.Data.DataType:DATE).
        tableDesc1:Columns = arrayvar15.
        THIS-OBJECT:bsReporte:TableSchema = tableDesc1.
        /*  */
        /* grCamposSelec */
        /*  */
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Appearance = appearance13.
        THIS-OBJECT:grCamposSelec:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ResizeAllColumns.
        THIS-OBJECT:grCamposSelec:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:grCamposSelec:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:grCamposSelec:DisplayLayout:MaxRowScrollRegions = 1.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving:NotAllowed.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:AllowColSizing = Infragistics.Win.UltraWinGrid.AllowColSizing:None.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:AllowRowLayoutCellSizing = Infragistics.Win.UltraWinGrid.RowLayoutSizing:None.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:AllowRowLayoutLabelSizing = Infragistics.Win.UltraWinGrid.RowLayoutSizing:None.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:CellPadding = 2.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:ExpansionIndicator = Infragistics.Win.UltraWinGrid.ShowExpansionIndicator:Never.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:Select.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:RowSizing = Infragistics.Win.UltraWinGrid.RowSizing:AutoFixed.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:grCamposSelec:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:grCamposSelec:DisplayLayout:RowConnectorStyle = Infragistics.Win.UltraWinGrid.RowConnectorStyle:None.
        THIS-OBJECT:grCamposSelec:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:grCamposSelec:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:grCamposSelec:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:grCamposSelec:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:grCamposSelec:MultipleBandSupport = Infragistics.Win.UltraWinGrid.MultipleBandSupport:DisplayColumnsFromAllBands.
        THIS-OBJECT:grCamposSelec:Name = "grCamposSelec".
        THIS-OBJECT:grCamposSelec:Size = NEW System.Drawing.Size(616, 289).
        THIS-OBJECT:grCamposSelec:SourceGrid = THIS-OBJECT:grReporte.
        THIS-OBJECT:grCamposSelec:StyleLibraryName = "".
        THIS-OBJECT:grCamposSelec:StyleSetName = "".
        THIS-OBJECT:grCamposSelec:TabIndex = 0.
        THIS-OBJECT:grCamposSelec:Text = "ultraGridColumnChooser1".
        /*  */
        /* DesignerForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(799, 589).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnPrincipal).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:barOpciones).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnTop).
        THIS-OBJECT:Name = "DesignerForm".
        THIS-OBJECT:Text = "Diseñador de Reportes".
        THIS-OBJECT:Shown:Subscribe(THIS-OBJECT:DesignerForm_Shown).
        THIS-OBJECT:ultraExplorerBarContainerControl1:ResumeLayout(FALSE).
        THIS-OBJECT:pnTop:ResumeLayout(FALSE).
        THIS-OBJECT:pnTop:PerformLayout().
        CAST(THIS-OBJECT:barOpciones, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:barOpciones:ResumeLayout(FALSE).
        THIS-OBJECT:pnPrincipal:ResumeLayout(FALSE).
        THIS-OBJECT:pnGrid:ResumeLayout(FALSE).
        THIS-OBJECT:grTablasWhere:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:grReporte, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsGrid, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:pnFooter:ResumeLayout(FALSE).
        THIS-OBJECT:folderOpciones:ResumeLayout(FALSE).
        THIS-OBJECT:tabDetalles:ResumeLayout(FALSE).
        THIS-OBJECT:tabDetalles:PerformLayout().
        THIS-OBJECT:tabCampos:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:bsReporte, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:grCamposSelec, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID lsTablas_ItemDrag(INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.ItemDragEventArgs):
	    lsTablas:DoDragDrop(e:Item, DragDropEffects:Copy).
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID ProcesarCondiciones(INPUT pcBuffer AS CHARACTER):
		DEFINE VARIABLE condiciones    AS mfvsys.Reporte.ui.WhereDialog NO-UNDO.
		DEFINE VARIABLE enDialogResult AS DialogResult                  NO-UNDO.
        DEFINE VARIABLE cCampos        AS System.Object          EXTENT NO-UNDO.
        DEFINE VARIABLE cParams        AS System.Object          EXTENT NO-UNDO.
        DEFINE VARIABLE i              AS INT64                         NO-UNDO.
        DEFINE VARIABLE auxClass       AS BasicKeyNameElement           NO-UNDO.

        DEFINE QUERY qCampos FOR eReporteSchCampo.
        OPEN QUERY qCampos PRESELECT EACH eReporteSchCampo WHERE eReporteSchCampo.Tabla = pcBuffer NO-LOCK.

        EXTENT(cCampos) = QUERY qCampos:NUM-RESULTS.
        REPEAT:
            IF NOT QUERY qCampos:GET-NEXT(NO-LOCK) THEN
                LEAVE.
            auxClass = NEW BasicKeyNameElement(eReporteSchCampo.Tipo, eReporteSchCampo.Campo).
            ASSIGN i = i + 1
                   cCampos[i] = auxClass.
        END.
        CLOSE QUERY qCampos.

        DEFINE QUERY qPredef FOR eReporteParamPredef.
        OPEN QUERY qPredef PRESELECT EACH eReporteParamPredef NO-LOCK.

        ASSIGN i = 0.
        EXTENT(cParams) = QUERY qPredef:NUM-RESULTS.
        REPEAT:
            IF NOT QUERY qPredef:GET-NEXT(NO-LOCK) THEN
                LEAVE.
            ASSIGN i = i + 1
                   cParams[i] = eReporteParamPredef.Nombre.
        END.
        CLOSE QUERY qPredef.

        ASSIGN condiciones            = NEW mfvsys.Reporte.ui.WhereDialog()
               condiciones:BufferName = pcBuffer
               condiciones:Campos     = cCampos
               condiciones:Params     = cParams.

        WAIT-FOR condiciones:ShowDialog() SET enDialogResult.
        IF EnumHelper:AreEqual (INPUT enDialogResult, INPUT DialogResult:OK) THEN DO:
            EMPTY TEMP-TABLE eReporteBuffCond.
            condiciones:ObtieneTempTable(OUTPUT TABLE eReporteBuffCond APPEND).
        END.
	END METHOD.

	DESTRUCTOR PUBLIC DesignerForm():
	END DESTRUCTOR.
END CLASS.