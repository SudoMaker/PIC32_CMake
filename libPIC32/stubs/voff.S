/* 
 * Written by Primož Kranjec, 2020
 *
 * The PIC32MZ is an interesting device,
 * where one can ON-THE-FLY remap interrupt vectors.
 * A great feature, but that also means that on startup,
 * they need to be set properly for "normal" usage.
 *
 * There are a total of 256 OFF registers, but not all are always present
 * There are 3 tactics that we can take:
 *     1. #ifdef all OFF000...OFF255 vectors,
 *        and only populate the ones that are present
 * 
 *     2. memset(OFF000, 256*sizeof(uint32_t), __vector_offset_default)
 *        and then ifdef all OFF-s
 *
 *     3. Do a sort of 
 *        OFF000 = __vector_offset_000,
 *         ...
 *        OFF255 = __vector_offset_255,
 *
 * Now, the datasheets doesn't say if writing to "missing" OFF-s is bad.
 * I'd wager, that nothing bad will happen...
 *
 * Implemented tactic 1, because I only want to do this once.
 * We have all the vector offsets (always 256 vectors),
 * and then a smaller subset (present), defined/generated in interrupt.S
 * Combined, we get this...
*/

#include <xc.h>
#include <cp0defs.h>

#define baseRegister	t0	/* Pointer to OFF000 */
#define baseVector		t1	/* Pointer to __vector_offset_0 */
#define basePresent		t2	/* Pointer to .voff.startup.pic32_voff_present_interrupts */
#define counter			t3	/* Counter from _voff_present_interrupts_end to begin */
#define temp			t4
#define targetRegister	t5	/* Pointer to OFF000 + offset */


.section .voff.pic32_voff_init,"xa"
	.set nomips16
	.globl __pic32_voff_init; .ent __pic32_voff_init;
__pic32_voff_init:

	la baseRegister, _voff_vector_offsets_begin		/* Load address of pointer to first vector (OFF000) */
	lw baseRegister, 0(baseRegister)				/* Load value from that address ... */
	la baseVector, (_voff_vector_offsets_begin + 4)	/* Load address of first vector_offsets */
	la basePresent, _voff_present_interrupts_begin	/* Load address of present_interrupts_begin */
	
	la counter, _voff_present_interrupts_end	/* Get address of end */
	sub counter, counter, basePresent			/* Subtract address of begin, make a length counter... */

	beq counter, $0, _voff_end
	/* Auto nop by compiler */
	
_voff_loop:	
	add temp, counter, basePresent			/* Calculate *(present + counter), save into temp	*/
	sub temp, temp, 4						/* Off by one fix, since counter points to ones more	*/
	lw temp, 0(temp)						/* Get offset from list, save into temp */ 
	add targetRegister, baseRegister, temp	/* Calculate OFFxyz ( *(OFF000 + temp)), save into targetRegister */
	add temp, baseVector, temp				/* Get address of vector_offset, store into temp */
	lw temp, 0(temp)						/* Load value from address of vector_offset into temp...*/
	sw temp, 0(targetRegister)				/* Store proper vector_offset into proper OFFxyz */
	sub counter, counter, 4					/* Decrease counter by 32-bits */
	
	bne counter, $0, _voff_loop				/* Repeat until all values copied over */
	/* Auto nop by compiler */
	
	
_voff_end:
	jr ra
	/* Auto nop by compiler */	
	.size __pic32_voff_init,.-__pic32_voff_init; .end __pic32_voff_init;

/* Constants section, because I can't trick it to work directly
 * -> The problem is, that these aren't defined at compile time...
 * -> So we just store them, and linker will substite with values
 * -> But, we don't know which ones are redundant, so there is a 
 * -> second array, generated in interrupt.S, that provides the OFFxyzs.
 * Hackish, but it works for everything.
 */
.section .voff.pic32_voff_vector_offsets
__pic32_voff_vector_offsets:	
	.word OFF000				/* The first entry is the base of OFF000 */
	.word __vector_offset_0
	.word __vector_offset_1
	.word __vector_offset_2
	.word __vector_offset_3
	.word __vector_offset_4
	.word __vector_offset_5
	.word __vector_offset_6
	.word __vector_offset_7
	.word __vector_offset_8
	.word __vector_offset_9
	.word __vector_offset_10
	.word __vector_offset_11
	.word __vector_offset_12
	.word __vector_offset_13
	.word __vector_offset_14
	.word __vector_offset_15
	.word __vector_offset_16
	.word __vector_offset_17
	.word __vector_offset_18
	.word __vector_offset_19
	.word __vector_offset_20
	.word __vector_offset_21
	.word __vector_offset_22
	.word __vector_offset_23
	.word __vector_offset_24
	.word __vector_offset_25
	.word __vector_offset_26
	.word __vector_offset_27
	.word __vector_offset_28
	.word __vector_offset_29
	.word __vector_offset_30
	.word __vector_offset_31
	.word __vector_offset_32
	.word __vector_offset_33
	.word __vector_offset_34
	.word __vector_offset_35
	.word __vector_offset_36
	.word __vector_offset_37
	.word __vector_offset_38
	.word __vector_offset_39
	.word __vector_offset_40
	.word __vector_offset_41
	.word __vector_offset_42
	.word __vector_offset_43
	.word __vector_offset_44
	.word __vector_offset_45
	.word __vector_offset_46
	.word __vector_offset_47
	.word __vector_offset_48
	.word __vector_offset_49
	.word __vector_offset_50
	.word __vector_offset_51
	.word __vector_offset_52
	.word __vector_offset_53
	.word __vector_offset_54
	.word __vector_offset_55
	.word __vector_offset_56
	.word __vector_offset_57
	.word __vector_offset_58
	.word __vector_offset_59
	.word __vector_offset_60
	.word __vector_offset_61
	.word __vector_offset_62
	.word __vector_offset_63
	.word __vector_offset_64
	.word __vector_offset_65
	.word __vector_offset_66
	.word __vector_offset_67
	.word __vector_offset_68
	.word __vector_offset_69
	.word __vector_offset_70
	.word __vector_offset_71
	.word __vector_offset_72
	.word __vector_offset_73
	.word __vector_offset_74
	.word __vector_offset_75
	.word __vector_offset_76
	.word __vector_offset_77
	.word __vector_offset_78
	.word __vector_offset_79
	.word __vector_offset_80
	.word __vector_offset_81
	.word __vector_offset_82
	.word __vector_offset_83
	.word __vector_offset_84
	.word __vector_offset_85
	.word __vector_offset_86
	.word __vector_offset_87
	.word __vector_offset_88
	.word __vector_offset_89
	.word __vector_offset_90
	.word __vector_offset_91
	.word __vector_offset_92
	.word __vector_offset_93
	.word __vector_offset_94
	.word __vector_offset_95
	.word __vector_offset_96
	.word __vector_offset_97
	.word __vector_offset_98
	.word __vector_offset_99
	.word __vector_offset_100
	.word __vector_offset_101
	.word __vector_offset_102
	.word __vector_offset_103
	.word __vector_offset_104
	.word __vector_offset_105
	.word __vector_offset_106
	.word __vector_offset_107
	.word __vector_offset_108
	.word __vector_offset_109
	.word __vector_offset_110
	.word __vector_offset_111
	.word __vector_offset_112
	.word __vector_offset_113
	.word __vector_offset_114
	.word __vector_offset_115
	.word __vector_offset_116
	.word __vector_offset_117
	.word __vector_offset_118
	.word __vector_offset_119
	.word __vector_offset_120
	.word __vector_offset_121
	.word __vector_offset_122
	.word __vector_offset_123
	.word __vector_offset_124
	.word __vector_offset_125
	.word __vector_offset_126
	.word __vector_offset_127
	.word __vector_offset_128
	.word __vector_offset_129
	.word __vector_offset_130
	.word __vector_offset_131
	.word __vector_offset_132
	.word __vector_offset_133
	.word __vector_offset_134
	.word __vector_offset_135
	.word __vector_offset_136
	.word __vector_offset_137
	.word __vector_offset_138
	.word __vector_offset_139
	.word __vector_offset_140
	.word __vector_offset_141
	.word __vector_offset_142
	.word __vector_offset_143
	.word __vector_offset_144
	.word __vector_offset_145
	.word __vector_offset_146
	.word __vector_offset_147
	.word __vector_offset_148
	.word __vector_offset_149
	.word __vector_offset_150
	.word __vector_offset_151
	.word __vector_offset_152
	.word __vector_offset_153
	.word __vector_offset_154
	.word __vector_offset_155
	.word __vector_offset_156
	.word __vector_offset_157
	.word __vector_offset_158
	.word __vector_offset_159
	.word __vector_offset_160
	.word __vector_offset_161
	.word __vector_offset_162
	.word __vector_offset_163
	.word __vector_offset_164
	.word __vector_offset_165
	.word __vector_offset_166
	.word __vector_offset_167
	.word __vector_offset_168
	.word __vector_offset_169
	.word __vector_offset_170
	.word __vector_offset_171
	.word __vector_offset_172
	.word __vector_offset_173
	.word __vector_offset_174
	.word __vector_offset_175
	.word __vector_offset_176
	.word __vector_offset_177
	.word __vector_offset_178
	.word __vector_offset_179
	.word __vector_offset_180
	.word __vector_offset_181
	.word __vector_offset_182
	.word __vector_offset_183
	.word __vector_offset_184
	.word __vector_offset_185
	.word __vector_offset_186
	.word __vector_offset_187
	.word __vector_offset_188
	.word __vector_offset_189
	.word __vector_offset_190
	.word __vector_offset_191
	.word __vector_offset_192
	.word __vector_offset_193
	.word __vector_offset_194
	.word __vector_offset_195
	.word __vector_offset_196
	.word __vector_offset_197
	.word __vector_offset_198
	.word __vector_offset_199
	.word __vector_offset_200
	.word __vector_offset_201
	.word __vector_offset_202
	.word __vector_offset_203
	.word __vector_offset_204
	.word __vector_offset_205
	.word __vector_offset_206
	.word __vector_offset_207
	.word __vector_offset_208
	.word __vector_offset_209
	.word __vector_offset_210
	.word __vector_offset_211
	.word __vector_offset_212
	.word __vector_offset_213
	.word __vector_offset_214
	.word __vector_offset_215
	.word __vector_offset_216
	.word __vector_offset_217
	.word __vector_offset_218
	.word __vector_offset_219
	.word __vector_offset_220
	.word __vector_offset_221
	.word __vector_offset_222
	.word __vector_offset_223
	.word __vector_offset_224
	.word __vector_offset_225
	.word __vector_offset_226
	.word __vector_offset_227
	.word __vector_offset_228
	.word __vector_offset_229
	.word __vector_offset_230
	.word __vector_offset_231
	.word __vector_offset_232
	.word __vector_offset_233
	.word __vector_offset_234
	.word __vector_offset_235
	.word __vector_offset_236
	.word __vector_offset_237
	.word __vector_offset_238
	.word __vector_offset_239
	.word __vector_offset_240
	.word __vector_offset_241
	.word __vector_offset_242
	.word __vector_offset_243
	.word __vector_offset_244
	.word __vector_offset_245
	.word __vector_offset_246
	.word __vector_offset_247
	.word __vector_offset_248
	.word __vector_offset_249
	.word __vector_offset_250
	.word __vector_offset_251
	.word __vector_offset_252
	.word __vector_offset_253
	.word __vector_offset_254
	.word __vector_offset_255

	
