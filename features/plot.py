import couchdb, IPython
import matplotlib.pyplot as plt
from pylab import plot, show, figure, imshow
import numpy as np

class GesPlotter:
    def __init__(self):
        self.srv = couchdb.Server()
        self.db = self.srv["ges-features"]

    def plot(self, defname):
        for row in self.db.view("views/doc_by_defname", key=defname):
            doc = row.value
        if doc:
            self.showMelBands(doc['frames']['lowlevel']['melbands'])

    def showMelBands(self, bands):
        melbands = np.array(bands).T
        imshow(melbands[:,:], aspect = 'auto', origin='lower', interpolation='none')
        plt.title("Mel band spectral energies in frames")
        show()

GesPlotter().plot('gep_gen000_010_151007_165550')
