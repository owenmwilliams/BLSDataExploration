import sys
from PySide2.QtWidgets import QApplication, QLabel
import plotly.graph_objects as go
import plotly.express as px
import pandas as pd


fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
fig.show()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    fig.show()
    sys.exit(app.exec_())
