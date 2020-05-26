
import Foundation

@_functionBuilder
public struct SearchableBuilder { }

extension SearchableBuilder {

    public static func buildBlock() -> EmptySearchable {
        return EmptySearchable()
    }

    public static func buildBlock<Content : Searchable>(_ content: Content) -> Content {
        return content
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable>(_ c1: C1, _ c2: C2) -> TupleSearchable<(C1, C2)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3) -> TupleSearchable<(C1, C2, C3)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleSearchable<(C1, C2, C3, C4)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> TupleSearchable<(C1, C2, C3, C4, C5)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> TupleSearchable<(C1, C2, C3, C4, C5, C6)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable, C14 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable(), c14.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable, C14 : Searchable, C15 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable(), c14.eraseToAnySearchable(), c15.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable, C14 : Searchable, C15 : Searchable, C16 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable(), c14.eraseToAnySearchable(), c15.eraseToAnySearchable(), c16.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable, C14 : Searchable, C15 : Searchable, C16 : Searchable, C17 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable(), c14.eraseToAnySearchable(), c15.eraseToAnySearchable(), c16.eraseToAnySearchable(), c17.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable, C14 : Searchable, C15 : Searchable, C16 : Searchable, C17 : Searchable, C18 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable(), c14.eraseToAnySearchable(), c15.eraseToAnySearchable(), c16.eraseToAnySearchable(), c17.eraseToAnySearchable(), c18.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable, C14 : Searchable, C15 : Searchable, C16 : Searchable, C17 : Searchable, C18 : Searchable, C19 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18, _ c19: C19) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable(), c14.eraseToAnySearchable(), c15.eraseToAnySearchable(), c16.eraseToAnySearchable(), c17.eraseToAnySearchable(), c18.eraseToAnySearchable(), c19.eraseToAnySearchable()])
    }

    public static func buildBlock<C1 : Searchable, C2 : Searchable, C3 : Searchable, C4 : Searchable, C5 : Searchable, C6 : Searchable, C7 : Searchable, C8 : Searchable, C9 : Searchable, C10 : Searchable, C11 : Searchable, C12 : Searchable, C13 : Searchable, C14 : Searchable, C15 : Searchable, C16 : Searchable, C17 : Searchable, C18 : Searchable, C19 : Searchable, C20 : Searchable>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10, _ c11: C11, _ c12: C12, _ c13: C13, _ c14: C14, _ c15: C15, _ c16: C16, _ c17: C17, _ c18: C18, _ c19: C19, _ c20: C20) -> TupleSearchable<(C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20)> {
        return TupleSearchable(values: [c1.eraseToAnySearchable(), c2.eraseToAnySearchable(), c3.eraseToAnySearchable(), c4.eraseToAnySearchable(), c5.eraseToAnySearchable(), c6.eraseToAnySearchable(), c7.eraseToAnySearchable(), c8.eraseToAnySearchable(), c9.eraseToAnySearchable(), c10.eraseToAnySearchable(), c11.eraseToAnySearchable(), c12.eraseToAnySearchable(), c13.eraseToAnySearchable(), c14.eraseToAnySearchable(), c15.eraseToAnySearchable(), c16.eraseToAnySearchable(), c17.eraseToAnySearchable(), c18.eraseToAnySearchable(), c19.eraseToAnySearchable(), c20.eraseToAnySearchable()])
    }

}
