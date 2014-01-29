GCJ = gcj
PREFIX = /usr
ECJJAR = ecj-3.5.2.jar
JARDIR = /share/java

all: ecj


ecj.jar:
	ant

ecj: ecj.jar
	$(GCJ) -Wl,-Bsymbolic -findirect-dispatch --main=org.eclipse.jdt.internal.compiler.batch.Main ecj.jar -lgcj -lgcj_bc -lgcc -o ecj -Wl,-Bsymbolic

clean:
	rm -f *.jar ecj

distclean: clean

install: all
	install -d ${DESTDIR}${PREFIX}${JARDIR} ${DESTDIR}${PREFIX}/bin ${DESTDIR}${PREFIX}/${LIBDIR}/jvm/gcj-jdk/bin
	install -t ${DESTDIR}${PREFIX}/bin ecj
	install -m 644 -T ecj.jar ${DESTDIR}${PREFIX}${JARDIR}/${ECJJAR}
	ln -r -s -f ${DESTDIR}${PREFIX}${JARDIR}/${ECJJAR} ${DESTDIR}${PREFIX}${JARDIR}/ecj.jar
	if [ -e ${DESTDIR}${PREFIX}/${LIBDIR}/jvm/gcj-jdk/bin/javac ];then rm ${DESTDIR}${PREFIX}/${LIBDIR}/jvm/gcj-jdk/bin/javac;fi
	ln -sr ${DESTDIR}${PREFIX}/bin/ecj ${DESTDIR}${PREFIX}/${LIBDIR}/jvm/gcj-jdk/bin/javac
