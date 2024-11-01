CREATE DATABASE [ParkPoint];
GO

USE [ParkPoint];
GO

-- Tablas básicas (sin dependencias entre sí)
CREATE TABLE [dbo].[Genero](
    [id_genero] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_genero] VARCHAR(255) NOT NULL
);
GO

CREATE TABLE [dbo].[Ubicacion](
    [id_ubicacion] INT IDENTITY(1,1) PRIMARY KEY,
    [ubicacionX] FLOAT NOT NULL,
    [ubicacionY] FLOAT NOT NULL
);
GO

CREATE TABLE [dbo].[Marca](
    [id_marca] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_marca] VARCHAR(255) NOT NULL
);
GO

-- Tablas que dependen de las tablas básicas
CREATE TABLE [dbo].[Modelo](
    [id_modelo] INT IDENTITY(1,1) PRIMARY KEY,
    [nombre_modelo] VARCHAR(255) NOT NULL,
    [id_marca] INT NOT NULL,
    FOREIGN KEY ([id_marca]) REFERENCES [dbo].[Marca]([id_marca])
);
GO

CREATE TABLE [dbo].[Usuario](
    [id_usuario] INT IDENTITY(1,1) PRIMARY KEY,
    [dni] INT NOT NULL,
    [foto_dni] VARCHAR(255) NOT NULL,
    [nombre] VARCHAR(255) NOT NULL,
    [apellido] VARCHAR(255) NOT NULL,
    [fecha_nacimiento] DATE NOT NULL,
    [email] VARCHAR(255) NOT NULL,
    [contrasena] VARCHAR(255) NOT NULL,
    [fecha_registro] DATE NOT NULL,
    [fecha_vencimiento_carnet] DATE NOT NULL,
    [foto_carnet] VARCHAR(255) NOT NULL,
    [foto_usuario] VARCHAR(255) NULL,
    [id_genero] INT NOT NULL,
    [id_ubicacion] INT NOT NULL,
    FOREIGN KEY ([id_ubicacion]) REFERENCES [dbo].[Ubicacion]([id_ubicacion]),
    FOREIGN KEY ([id_genero]) REFERENCES [dbo].[Genero]([id_genero])
);
GO

-- Continuar con otras tablas dependientes
CREATE TABLE [dbo].[Auto](
    [id_auto] INT IDENTITY(1,1) PRIMARY KEY,
    [patente] VARCHAR(50) NOT NULL UNIQUE,
    [id_usuario] INT NOT NULL,
    [id_marca] INT NOT NULL,
    [id_modelo] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_marca]) REFERENCES [dbo].[Marca]([id_marca]),
    FOREIGN KEY ([id_modelo]) REFERENCES [dbo].[Modelo]([id_modelo])
);
GO

CREATE TABLE [dbo].[Estacionamiento](
    [id_estacionamiento] INT IDENTITY(1,1) PRIMARY KEY,
    [sePuedeEstacionar] BIT NOT NULL,
    [ocupado] BIT NOT NULL,
    [calle] TEXT NOT NULL,
    [altura_calle] TEXT NOT NULL,
    [fecha_libre] DATE NOT NULL,
    [fecha_ocupado] DATE NOT NULL,
    [tiempo_estacionado] TIME(7) NOT NULL,
    [tiempo_promedio_llegada] TIME(7) NOT NULL,
    [id_auto] INT NOT NULL,
    [id_usuario] INT NOT NULL,
    [id_ubicacion] INT NOT NULL,
    FOREIGN KEY ([id_ubicacion]) REFERENCES [dbo].[Ubicacion]([id_ubicacion]),
    FOREIGN KEY ([id_auto]) REFERENCES [dbo].[Auto]([id_auto]),
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

CREATE TABLE [dbo].[Puntos](
    [id_puntos] INT IDENTITY(1,1) PRIMARY KEY,
    [cantidad] TEXT NOT NULL,
    [fecha_actualizacion] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

CREATE TABLE [dbo].[Canjeo](
    [id_canjeo] INT IDENTITY(1,1) PRIMARY KEY,
    [fecha_canjeo] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    [id_puntos] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_puntos]) REFERENCES [dbo].[Puntos]([id_puntos])
);
GO

CREATE TABLE [dbo].[Recompensa](
    [id_recompensa] INT IDENTITY(1,1) PRIMARY KEY,
    [titulo] TEXT NOT NULL,
    [descripcion] TEXT NOT NULL,
    [puntos_necesarios] INT NOT NULL,
    [imagen] VARCHAR(255) NULL,
    [id_canjeo] INT NOT NULL,
    FOREIGN KEY ([id_canjeo]) REFERENCES [dbo].[Canjeo]([id_canjeo])
);
GO

CREATE TABLE [dbo].[Notificacion](
    [id_notificacion] INT IDENTITY(1,1) PRIMARY KEY,
    [titulo] TEXT NOT NULL,
    [descripcion] TEXT NOT NULL,
    [fecha_notificacion] DATE NOT NULL,
    [leido] BIT NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

CREATE TABLE [dbo].[Registro](
    [id_registro] INT IDENTITY(1,1) PRIMARY KEY,
    [registro_aprobado] BIT NOT NULL,
    [id_usuario] INT NOT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario])
);
GO

CREATE TABLE [dbo].[Tiempo_Real](
    [id_motivo_tiempo_real] INT IDENTITY(1,1) PRIMARY KEY,
    [descripcion] VARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[ReporteTiempoReal](
    [id_reporte_tiempo_real] INT IDENTITY(1,1) PRIMARY KEY,
    [id_ubicacion] INT NOT NULL,
    [id_motivo_tiempo_real] INT NOT NULL,
    FOREIGN KEY ([id_ubicacion]) REFERENCES [dbo].[Ubicacion]([id_ubicacion]),
    FOREIGN KEY ([id_motivo_tiempo_real]) REFERENCES [dbo].[Tiempo_Real]([id_motivo_tiempo_real])
);
GO

CREATE TABLE [dbo].[Infraccion](
    [id_motivo_infraccion] INT IDENTITY(1,1) PRIMARY KEY,
    [descripcion] VARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[ReporteInfraccion](
    [id_reporte_infraccion] INT IDENTITY(1,1) PRIMARY KEY,
    [calle_infraccion] VARCHAR(255) NULL,
    [altura_infraccion] VARCHAR(255) NULL,
    [patente_reportada] VARCHAR(50) NOT NULL,
    [id_auto_reportante] INT NOT NULL,
    [id_motivo_infraccion] INT NOT NULL,
    FOREIGN KEY ([patente_reportada]) REFERENCES [dbo].[Auto]([patente]), -- Conexión a la patente en Auto
    FOREIGN KEY ([id_auto_reportante]) REFERENCES [dbo].[Auto]([id_auto]), -- Auto que realiza el reporte
    FOREIGN KEY ([id_motivo_infraccion]) REFERENCES [dbo].[Infraccion]([id_motivo_infraccion]) -- Motivo de la infracción
);
GO


CREATE TABLE [dbo].[Reporte](
    [id_reporte] INT IDENTITY(1,1) PRIMARY KEY,
    [enTiempoRealOInfraccion] BIT NOT NULL,
    [fecha_reporte] DATE NOT NULL,
    [id_usuario] INT NOT NULL,
    [id_reporte_tiempo_real] INT NULL,
    [id_reporte_infraccion] INT NULL,
    FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[Usuario]([id_usuario]),
    FOREIGN KEY ([id_reporte_tiempo_real]) REFERENCES [dbo].[ReporteTiempoReal]([id_reporte_tiempo_real]),
    FOREIGN KEY ([id_reporte_infraccion]) REFERENCES [dbo].[ReporteInfraccion]([id_reporte_infraccion])
);
GO
