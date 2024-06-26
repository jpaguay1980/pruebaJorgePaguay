USE [prueba]
GO
/****** Object:  Table [dbo].[tblPrueba]    Script Date: 30/5/2024 4:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPrueba](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](50) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[FechaCreacion] [date] NOT NULL,
	[FechaVencimiento] [date] NOT NULL,
	[Completada] [char](1) NOT NULL,
 CONSTRAINT [PK_tblPrueba] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPrueba] ADD  CONSTRAINT [DF_tblPrueba_Completada]  DEFAULT ('N') FOR [Completada]
GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_registro]    Script Date: 30/5/2024 4:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jorge Paguay
-- Create date: 30/05/2024
-- Description:	Crea consulta en tabla de prueba
-- exec sp_consulta_registro 0
-- =============================================
CREATE   PROCEDURE [dbo].[sp_consulta_registro] @id int	 
AS
BEGIN
	SET NOCOUNT ON;
	select 0 codigoError, 'Se consulto la información de forma correcta' mensajeError;
	select id, titulo ,descripcion,
		   FORMAT( fechacreacion, 'dd/MM/yyyy')  as fechacreacion,
		   FORMAT( fechavencimiento, 'dd/MM/yyyy')  as fechavencimiento,
		   completada
	from [dbo].[tblPrueba]
	 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_crear_registro]    Script Date: 30/5/2024 4:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jorge Paguay
-- Create date: 30/05/2024
-- Description:	Crea registro en tabla de prueba
-- =============================================
CREATE   PROCEDURE [dbo].[sp_crear_registro]
	@Opcion             varchar(10),
	@Id					int	,
	@Titulo				varchar(50)	,
	@Descripcion		varchar(100)	,
	@FechaCreacion		date	,
	@FechaVencimiento	date	,
	@Completada			char(1)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF(@Opcion='INS')
	begin 
		insert into [dbo].[tblPrueba](Titulo ,Descripcion,FechaCreacion,FechaVencimiento,Completada)		
		  values(@Titulo,@Descripcion,@FechaCreacion,@FechaVencimiento,@Completada) 
		select 0 codigoError, 'Se ingresó la información de forma correcta' mensajeError;
	end
	IF(@Opcion='UPD')
	begin 
		UPDATE [dbo].[tblPrueba]
		set Titulo = @Titulo ,
			Descripcion=@Descripcion,
			FechaCreacion=@FechaCreacion,
			FechaVencimiento=@FechaVencimiento,
			Completada=@Completada
		where id = @Id
		select 0 codigoError, 'Se actualizó la información de forma correcta' mensajeError;
	end
	IF(@OPCION='ELIM') 
	BEGIN 
		DELETE FROM [dbo].[tblPrueba]
		WHERE id=@ID;
		select 0 codigoError, 'Se elimino el registro de forma correcta' mensajeError;
	END
	IF(@OPCION='SEL')
	BEGIN
		select 0 codigoError, 'Se consulto la información de forma correcta' mensajeError;
		SELECT id, titulo ,descripcion,
		   FORMAT( fechacreacion, 'dd-MM-yyyy hh:mm:ss tt')  as fechacreacion,
		   FORMAT( fechavencimiento, 'dd-MM-yyyy hh:mm:ss tt')  as fechavencimiento,
		   completada
		FROM [dbo].[tblPrueba]
		WHERE id=@Id;
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimiento_registro]    Script Date: 30/5/2024 4:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jorge Paguay
-- Create date: 30/05/2024
-- Description:	Crea registro en tabla de prueba
-- =============================================
CREATE   PROCEDURE [dbo].[sp_mantenimiento_registro] @Opcion             varchar(10),
													@Id					int	,
													@Titulo				varchar(50)	,
													@Descripcion		varchar(100)	,
													@FechaCreacion		date	,
													@FechaVencimiento	date	,
													@Completada			char(1)	
AS
BEGIN
	SET NOCOUNT ON;
	IF(@Opcion='INS')
	begin 
		insert into [dbo].[tblPrueba](Titulo ,Descripcion,FechaCreacion,FechaVencimiento,Completada)		
		  values(@Titulo,@Descripcion,@FechaCreacion,@FechaVencimiento,@Completada) 
		select 0 codigoError, 'Se ingresó la información de forma correcta' mensajeError;
	end
	IF(@Opcion='UPD')
	begin 
		UPDATE [dbo].[tblPrueba]
		set Titulo = @Titulo ,
			Descripcion=@Descripcion,
			FechaCreacion=@FechaCreacion,
			FechaVencimiento=@FechaVencimiento,
			Completada=@Completada
		where id = @Id
		select 0 codigoError, 'Se actualizó la información de forma correcta' mensajeError;
	end
	IF(@OPCION='ELIM') 
	BEGIN 
		DELETE FROM [dbo].[tblPrueba]
		WHERE id=@ID;
		select 0 codigoError, 'Se elimino el registro de forma correcta' mensajeError;
	END
	IF(@OPCION='SEL')
	BEGIN
		select 0 codigoError, 'Se consulto la información de forma correcta' mensajeError;
		SELECT id, titulo ,descripcion,
		   FORMAT( fechacreacion, 'dd-MM-yyyy hh:mm:ss tt')  as fechacreacion,
		   FORMAT( fechavencimiento, 'dd-MM-yyyy hh:mm:ss tt')  as fechavencimiento,
		   completada
		FROM [dbo].[tblPrueba]
		WHERE id=@Id;
	END	
END
GO
