import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import mysql.connector

class VentanaPrincipal:
    def __init__(self, root):
        self.root = root
        self.root.title("Gestión Náutica")

        # Conexión a la base de datos MySQL
        self.conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="admin",
            database="gestion_nautica"
        )
        self.cursor = self.conn.cursor()

        # Crear un contenedor de pestañas
        self.notebook = ttk.Notebook(root)
        self.notebook.pack(fill='both', expand=True)

        # Crear la pestaña para la vista proximos_tramites
        self.pestaña_proximos_tramites = ttk.Frame(self.notebook)
        self.notebook.add(self.pestaña_proximos_tramites, text="Próximos Trámites")

        # Configurar Treeview para la vista proximos_tramites
        self.tree_proximos_tramites = ttk.Treeview(self.pestaña_proximos_tramites, columns=("ID", "APELLIDO", "NOMBRE", "CUIL", "CLAVE_CIDI", "TELEFONO", "TRAMITE", "MATRICULA", "OTORGADO", "VENCIMIENTO", "DIAS_RENOVACION"))
        self.configurar_treeview(self.tree_proximos_tramites, mostrar_vencimiento=True)
        self.tree_proximos_tramites.pack()

        # Botón para agregar cliente (solo en la pestaña proximos_tramites)
        self.boton_agregar_tramite = ttk.Button(self.pestaña_proximos_tramites, text="Agregar Trámite", command=self.agregar_tramite)
        self.boton_agregar_tramite.pack()

        # Botón para modificar trámite (solo en la pestaña proximos_tramites)
        self.boton_modificar_tramite_proximos = ttk.Button(self.pestaña_proximos_tramites, text="Modificar Trámite", command=self.modificar_tramite)
        self.boton_modificar_tramite_proximos.pack()

        # Cargar datos automáticamente al iniciar la aplicación
        self.cargar_datos()

        # Crear la pestaña para la vista tramites_en_proceso
        self.pestaña_tramites_en_proceso = ttk.Frame(self.notebook)
        self.notebook.add(self.pestaña_tramites_en_proceso, text="Trámites en Proceso")

        # Configurar Treeview para la vista tramites_en_proceso
        self.tree_tramites_en_proceso = ttk.Treeview(self.pestaña_tramites_en_proceso, columns=("ID", "APELLIDO", "NOMBRE", "CUIL", "CLAVE_CIDI", "TELEFONO", "TRAMITE", "MATRICULA", "OTORGADO", "VENCIMIENTO", "DIAS_RENOVACION"))
        self.configurar_treeview(self.tree_tramites_en_proceso, mostrar_vencimiento=True)
        self.tree_tramites_en_proceso.pack()

        # Botón para modificar trámite (solo en la pestaña tramites_en_proceso)
        self.boton_modificar_tramite_proceso = ttk.Button(self.pestaña_tramites_en_proceso, text="Modificar Trámite", command=lambda: self.modificar_tramite(vista="tramites_en_proceso"))
        self.boton_modificar_tramite_proceso.pack()


        # Cargar datos automáticamente al iniciar la aplicación para tramites_en_proceso
        self.cargar_datos(vista="tramites_en_proceso")

        # Crear la pestaña para la vista tramites_inactivos
        self.pestaña_tramites_inactivos = ttk.Frame(self.notebook)
        self.notebook.add(self.pestaña_tramites_inactivos, text="Trámites Inactivos")

        # Configurar Treeview para la vista tramites_inactivos
        self.tree_tramites_inactivos = ttk.Treeview(self.pestaña_tramites_inactivos, columns=("ID", "APELLIDO", "NOMBRE", "CUIL", "CLAVE_CIDI", "TELEFONO", "TRAMITE", "MATRICULA", "OTORGADO", "VENCIMIENTO", "DIAS_RENOVACION"))
        self.configurar_treeview(self.tree_tramites_inactivos, mostrar_vencimiento=True)
        self.tree_tramites_inactivos.pack()

        # Botón para modificar trámite en la pestaña tramites_inactivos
        self.boton_modificar_tramite_inactivos = ttk.Button(self.pestaña_tramites_inactivos, text="Modificar Trámite", command=lambda: self.modificar_tramite(vista="tramites_inactivos"))
        self.boton_modificar_tramite_inactivos.pack()

        # Cargar datos automáticamente al iniciar la aplicación para tramites_inactivos
        self.cargar_datos(vista="tramites_inactivos")

    def configurar_treeview(self, tree, mostrar_vencimiento=True):
        # Configuración de las columnas
        tree.column("#0", stretch=tk.NO, anchor="w", width=0)  # Ocultar la primera columna
        columnas = ("ID", "APELLIDO", "NOMBRE", "CUIL", "CLAVE_CIDI", "TELEFONO", "TRAMITE", "MATRICULA", "OTORGADO", "VENCIMIENTO", "DIAS_RENOVACION")
        for col in columnas:
            tree.column(col, anchor="w", width=100)

        # Configuración de los encabezados
        tree.heading("#0", text="")
        for col in columnas:
            tree.heading(col, text=col)

    def cargar_datos(self, vista="proximos_tramites"):
        # Limpiar Treeviews
        tree = None  # Asignar un valor inicial a 'tree'
        boton_modificar = None  # Asignar un valor inicial a 'boton_modificar'

        if vista == "proximos_tramites":
            tree = self.tree_proximos_tramites
            boton_modificar = self.boton_modificar_tramite_proximos
        elif vista == "tramites_en_proceso":
            tree = self.tree_tramites_en_proceso
            boton_modificar = self.boton_modificar_tramite_proceso
        elif vista == "tramites_inactivos":
            tree = self.tree_tramites_inactivos
            boton_modificar = self.boton_modificar_tramite_inactivos
        else:
            return

        boton_modificar.pack()

        # Borrar los elementos existentes en lugar de borrar todos los elementos
        if tree:
            tree.delete(*tree.get_children())

        # Insertar datos en el Treeview
        datos = self.obtener_datos(vista)
        for resultado in datos:
            tree.insert("", "end", values=resultado)

        # Configurar visibilidad del botón según la pestaña activa
        pestaña_activa = self.notebook.tab(self.notebook.select(), "text")
        if pestaña_activa == "Próximos Trámites":
            boton_modificar.pack()
        else:
            boton_modificar.pack()


    def obtener_datos(self, vista):
        consulta = ""
        if vista == "proximos_tramites":
            consulta = "SELECT * FROM proximos_tramites"
        elif vista == "tramites_en_proceso":
            consulta = "SELECT * FROM tramites_en_proceso"
        elif vista == "tramites_inactivos":
            consulta = "SELECT * FROM tramites_inactivos"

        self.cursor.execute(consulta)
        resultados = self.cursor.fetchall()
        return resultados

    
    def agregar_tramite(self):
        # Crear una nueva ventana para agregar trámite
        ventana_agregar = tk.Toplevel(self.root)
        ventana_agregar.title("Agregar Trámite")

        # Crear y configurar etiquetas y campos de entrada
        etiquetas = ["APELLIDO", "NOMBRE", "CUIL", "CLAVE_CIDI", "TELEFONO", "TRAMITE", "MATRICULA", "OTORGADO"]
        campos = {}
        for i, etiqueta in enumerate(etiquetas):
            ttk.Label(ventana_agregar, text=etiqueta).grid(row=i, column=0, padx=5, pady=5)
            if etiqueta == "TRAMITE":
                opciones_tramite = ["Licencia A", "Licencia C", "Licencia D", "Licencia O", "Bianual", "Matriculacion", "Transferencia","INACTIVO"]
                campos[etiqueta] = ttk.Combobox(ventana_agregar, values=opciones_tramite)
            else:
                campos[etiqueta] = ttk.Entry(ventana_agregar)
            campos[etiqueta].grid(row=i, column=1, padx=5, pady=5)

        # Función para guardar el nuevo trámite en la base de datos
        def guardar_tramite():
            datos_nuevo_tramite = [campos[etiqueta].get() for etiqueta in etiquetas]

            # Validar el formato de la fecha OTORGADO
            if not self.validar_formato_fecha(datos_nuevo_tramite[-1]):
                messagebox.showerror("Error al agregar trámite", "Ingrese una fecha correcta. Recuerde respetar el formato AÑO-MES-DIA.Ejemplo: 2018-01-25")
                return

            self.guardar_nuevo_tramite_en_bd(datos_nuevo_tramite)
            ventana_agregar.destroy()

        # Botón para guardar el nuevo trámite
        ttk.Button(ventana_agregar, text="Guardar", command=guardar_tramite).grid(row=len(etiquetas), column=0, columnspan=2, pady=10)

    def modificar_tramite(self, vista="proximos_tramites"):
        # Obtener el item seleccionado en el Treeview
        tree = None
        if vista == "proximos_tramites":
            tree = self.tree_proximos_tramites
        elif vista == "tramites_en_proceso":
            tree = self.tree_tramites_en_proceso
        elif vista == "tramites_inactivos":
            tree = self.tree_tramites_inactivos
        else:
            return

        item_seleccionado = tree.focus()

        if item_seleccionado:
            # Obtener los datos del item seleccionado
            datos_actuales = tree.item(item_seleccionado, 'values')

            # Crear una nueva ventana para modificar trámite
            ventana_modificar = tk.Toplevel(self.root)
            ventana_modificar.title("Modificar Trámite")

            # Crear y configurar etiquetas y campos de entrada
            etiquetas = ["APELLIDO", "NOMBRE", "CUIL", "CLAVE_CIDI", "TELEFONO", "TRAMITE", "MATRICULA", "OTORGADO"]
            campos = {}
            for i, (etiqueta, valor_actual) in enumerate(zip(etiquetas, datos_actuales[1:])):
                ttk.Label(ventana_modificar, text=etiqueta).grid(row=i, column=0, padx=5, pady=5)
                if etiqueta == "TRAMITE":
                    opciones_tramite = ["Licencia A", "Licencia C", "Licencia D", "Licencia O", "Bianual", "Matriculacion", "Transferencia","INACTIVO"]
                    campos[etiqueta] = ttk.Combobox(ventana_modificar, values=opciones_tramite)
                    campos[etiqueta].set(valor_actual)  # Establecer la opción seleccionada
                else:
                    campos[etiqueta] = ttk.Entry(ventana_modificar)
                    campos[etiqueta].insert(0, str(valor_actual))
                campos[etiqueta].grid(row=i, column=1, padx=5, pady=5)

            # Función para guardar los cambios
            def guardar_cambios():
                nuevos_datos = [campos[etiqueta].get() for etiqueta in etiquetas]

                # Validar el formato de la fecha OTORGADO
                if not self.validar_formato_fecha(nuevos_datos[-1]):
                    messagebox.showerror("Error al modificar trámite", "Ingrese una fecha correcta. Recuerde respetar el formato AÑO-MES-DIA.Ejemplo: 2018-01-25")
                    return

                # Implementar la lógica para actualizar los datos en la base de datos
                self.actualizar_datos_en_bd(item_seleccionado, nuevos_datos, vista)

                # Cerrar la ventana de modificación
                ventana_modificar.destroy()

            # Botón para guardar los cambios
            ttk.Button(ventana_modificar, text="Guardar Cambios", command=guardar_cambios).grid(row=len(etiquetas), column=0, columnspan=2, pady=10)


    def validar_formato_fecha(self, fecha_str):
        # Validar el formato AÑO-MES-DIA
        if len(fecha_str) != 10:
            return False
        try:
            year, month, day = map(int, fecha_str.split('-'))
            if not (1 <= month <= 12 and 1 <= day <= 31):
                return False
        except ValueError:
            return False
        return True

    def guardar_nuevo_tramite_en_bd(self, datos_tramite):
        # Insertar el nuevo trámite en la tabla tramites
        consulta = "INSERT INTO tramites (APELLIDO, NOMBRE, CUIL, CLAVE_CIDI, TELEFONO, TRAMITE, MATRICULA, OTORGADO) " \
                "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
        self.cursor.execute(consulta, tuple(datos_tramite))
        self.conn.commit()
        messagebox.showinfo("Agregar Trámite", "Trámite agregado correctamente.")
        
        # Volver a cargar los datos en ambas vistas
        self.cargar_datos(vista="proximos_tramites")
        self.cargar_datos(vista="tramites_en_proceso")
        self.cargar_datos(vista="tramites_inactivos")  # Agregar esta línea


    def actualizar_datos_en_bd(self, item_seleccionado, nuevos_datos, vista):
        # Obtener el ID del trámite seleccionado
        if vista == "tramites_en_proceso":
            trámite_id = self.tree_tramites_en_proceso.item(item_seleccionado, 'values')[0]
            pestaña_activa = "tramites_en_proceso"
            otra_pestaña = "proximos_tramites"
        elif vista == "tramites_inactivos":
            trámite_id = self.tree_tramites_inactivos.item(item_seleccionado, 'values')[0]
            pestaña_activa = "tramites_inactivos"
            otra_pestaña = "proximos_tramites"
        else:
            trámite_id = self.tree_proximos_tramites.item(item_seleccionado, 'values')[0]
            pestaña_activa = "proximos_tramites"
            otra_pestaña = "tramites_en_proceso"

        # Construir la consulta de actualización
        consulta = "UPDATE tramites SET APELLIDO = %s, NOMBRE = %s, CUIL = %s, CLAVE_CIDI = %s, TELEFONO = %s, TRAMITE = %s, MATRICULA = %s, OTORGADO = %s WHERE ID = %s"

        # Ejecutar la consulta de actualización sin agregar el ID a la lista de nuevos datos
        self.cursor.execute(consulta, tuple(nuevos_datos + [trámite_id]))
        self.conn.commit()

        # Mostrar un mensaje informativo
        messagebox.showinfo("Modificar Trámite", "Trámite modificado correctamente.")

        # Volver a cargar los datos en ambas pestañas
        self.cargar_datos(vista=pestaña_activa)
        self.cargar_datos(vista=otra_pestaña)




# Código principal
if __name__ == "__main__":
    root = tk.Tk()
    app = VentanaPrincipal(root)
    root.mainloop()

