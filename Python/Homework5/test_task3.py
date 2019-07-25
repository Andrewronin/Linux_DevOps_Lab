from unittest import TestCase
import task3


class Test(TestCase):

    def test_is_self_dividing(self):

        for i in range(1, 10):
            self.assertTrue(task3.is_self_dividing(i))

        self.assertFalse(task3.is_self_dividing(17))
        self.assertFalse(task3.is_self_dividing(13))
        self.assertTrue(task3.is_self_dividing(22))

    def test_rang(self):
        self.assertEqual(task3.rang(1, 50),
                         [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 22, 24, 33, 36, 44, 48])
        self.assertEqual(task3.rang(100, 200),
                         [111, 112, 115, 122, 124, 126, 128, 132,
                          135, 144, 155, 162, 168, 175, 184])
        self.assertEqual(task3.rang(300, 400), [312, 315, 324, 333, 336, 366, 384, 396])
