from colormath.color_objects import sRGBColor, LabColor
from colormath.color_conversions import convert_color
from colormath.color_diff import delta_e_cie2000
import yaml

def load_xterm_palette(yaml_path):
    with open(yaml_path, 'r') as f:
        data = yaml.safe_load(f)

    palette = []
    for section in (':xtermGreyscale', ':xterm256'): # bottom 16 NOT included
        for idx_str, hex_code in data.get(section, []):
            palette.append((int(idx_str), hex_code.lower()))
    return palette

def closest_xterm_index(target_hex, palette):
    """
    Given a hex color and a list of (index, hex) tuples from the xterm palette,
    returns the closest xterm color index and hex using CIE2000 delta E.
    Compatible with NumPy 2.0+.
    """
    target_rgb = sRGBColor.new_from_rgb_hex(target_hex)
    target_lab = convert_color(target_rgb, LabColor)

    min_dist = float('inf')
    best_match = None

    for index, hex_code in palette:
        rgb = sRGBColor.new_from_rgb_hex(hex_code)
        lab = convert_color(rgb, LabColor)
        dist = delta_e_cie2000(target_lab, lab)
        dist_val = dist.item() if hasattr(dist, "item") else dist  # NumPy 2.0-safe
        if dist_val < min_dist:
            min_dist = dist_val
            best_match = (index, hex_code)

    return best_match

palette = load_xterm_palette("xterm-256color.yaml")
colors = dict(
    base03="#232629",
    base02="#2f3438",
    base01="#6b747a",
    base00="#7a848b",
    base0="#97a0a6",
    base1="#a6aeb3",
    base2="#dfe3e3",
    base3="#f2f4f3",
    yellow="#b58900",
    orange="#cb4b16",
    red="#dc322f",
    magenta="#d33682",
    violet="#7b80c0",
    blue="#4b88b8",
    cyan="#4f9b95",
    green="#859900"
)
for k, v in colors.items():
    print(f"{k}: {closest_xterm_index(v, palette)}")
