/*
 * Adapted from original written by J.T. Conklin <jtc@netbsd.org>.
 * Public domain.
 *
 *	by Ian Ollmann, Apple Computer 2006
 */

#include <machine/asm.h>
#include "abi.h"


PRIVATE_ENTRY(__cosl)	//currently required for single and double
ENTRY(cosl)
	fldt	FIRST_ARG_OFFSET(STACKP)
	fcos
	fnstsw	%ax
	andw	$0x400,%ax
	jnz		1f
	ret
	
1:	fldpi
	fadd	%st(0)
	fxch	%st(1)
2:	fprem1
	fnstsw	%ax
	andw	$0x400,%ax
	jnz	2b
	fstp	%st(1)
	fcos
	ret
